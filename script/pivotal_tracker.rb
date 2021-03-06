URL = "https://www.pivotaltracker.com"
STOTS = "http://localhost:3000"

require 'faraday'
require 'faraday_middleware'
require 'typhoeus'
require 'nokogiri'
require 'time'

starting_time = Time.now

def puts(message)
  STDOUT.puts("[#{Time.now}] #{message}")
end

$connection = Faraday.new(:url => URL) do |builder|
  builder.use Faraday::Response::RaiseError
  builder.adapter :typhoeus
#  builder.use Faraday::Response::Logger
end

module SimpleXML
  def x(tag)
    search(tag).first.content
  end
end
Nokogiri::XML::Node.send(:include, SimpleXML)

$local_connection = Faraday.new(:url => STOTS) do |builder|
  builder.use Faraday::Request::UrlEncoded
  builder.use Faraday::Response::RaiseError
  builder.adapter :typhoeus
end

$connection.in_parallel(Typhoeus::Hydra.hydra) do
  $local_connection.in_parallel(Typhoeus::Hydra.hydra) do

    puts "Getting settings from Stots"

    settings = $local_connection.get do |req|
      req.url "/settings/pivotal_tracker.xml"
    end

    settings.on_complete do

      KEY = Nokogiri::XML(settings.body).search("//settings/api_key").first.content

      puts "Getting activity listing from Pivotal Tracker"

      response = $connection.get do |req|
        req.url "/services/v3/projects"
        req.headers['X-TrackerToken'] = KEY
      end

      response.on_complete do
        projects = Nokogiri::XML(response.body).search("//projects/project")
        puts "Got #{projects.size} projects"

        projects.each do |project|
          id = project.x("id")
          puts "Reading project #{id} - #{project.x("name")}"

          res = $connection.get do |req|
            req.url "/services/v3/projects/#{id}/activities"
            req.headers['X-TrackerToken'] = KEY
            req.params[:limit] = 1000
          end

          res2 = $connection.get do |req|
            req.headers['X-TrackerToken'] = KEY
            req.url "/services/v3/projects/#{id}/iterations"
          end

          res.on_complete do

            adoc = Nokogiri::XML(res.body).search("//activities/activity")
            puts "Retrieved #{adoc.size} activities for project #{project.x("name")}"

            activities = adoc.map do |activity|

              { :id => activity.x("id"),
                :event_type => activity.x("event_type"),
                :occurred_at => activity.x("occurred_at"),
                :author => activity.x("author"),
                :description => activity.x("description")
              }

            end

            res2.on_complete do

              idoc = Nokogiri::XML(res2.body).search("//iterations/iteration")
              puts "Retrieved #{idoc.size} iterations for project #{project.x("name")}"

              iterations = idoc.map do |iteration|
                { :id => iteration.x("id"),
                  :number => iteration.x("number"),
                  :start => iteration.x("start"),
                  :finish => iteration.x("finish"),
                  :team_strength => iteration.x("team_strength"),
                  :stories => iteration.search("stories/story").size
                }
              end

              data = {
                :id => id,
                :name => project.x("name"),
                :iteration_length => project.x("iteration_length"),
                :week_start_day => project.x("week_start_day"),
                :point_scale => project.x("point_scale"),
                :current_velocity => project.x("current_velocity"),
                :initial_velocity => project.x("initial_velocity"),
                :activities => activities,
                :iterations => iterations
              }

              puts "Sending data"

              local_response = $local_connection.post do |request|
                request.url "/pivotal_tracker/projects"
                request.body = { :project => data }
              end

              local_response.on_complete do
                puts "Saved project #{data[:name]}"
              end

            end

          end

        end
      end
    end
  end

end
puts "Done. It took me %.03f seconds" % (Time.now - starting_time)
