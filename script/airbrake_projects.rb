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

$local_connection = Faraday.new(:url => STOTS) do |builder|
  builder.use Faraday::Request::UrlEncoded
  builder.use Faraday::Response::RaiseError
  builder.adapter :typhoeus
end

puts "Getting settings from Stots"

response = $local_connection.get do |req|
  req.url "/settings/airbrake.xml"
end

response.on_complete do
  settings = Nokogiri::XML(response.body)
  KEY = settings.search("//settings/api_key").first.content
  URL = settings.search("//settings/account_url").first.content
end

$connection = Faraday.new(:url => URL) do |builder|
  builder.use Faraday::Response::RaiseError
  builder.adapter :typhoeus
end

puts "Getting project listing from Airbrake"


$connection.in_parallel(Typhoeus::Hydra.hydra) do
  $local_connection.in_parallel(Typhoeus::Hydra.hydra) do
    response = $connection.get do |request|
      request.url "/data_api/v1/projects.xml"
      request.params[:auth_token] = KEY
    end

    response.on_complete do

      puts "Got projects from Airbrake"

      doc = Nokogiri::XML(response.body)
      doc.search("//projects/project").each do |project|

        id = project.search("id").first.content

        deploys = $connection.get do |req|
          req.url "/projects/#{id}/deploys.xml"
          req.params[:auth_token] = KEY
        end

        deploys.on_complete do

          puts "Got deploys for project #{id}"

          data = {
            :id => id,
            :name => project.search("name").first.content,
            :api_key => project.search("api-key").first.content,
            :deploys => Nokogiri::XML(deploys.body).search("//projects/deploy").map { |deploy|
              {
                :id => deploy.search("id").first.content,
                :rails_env => deploy.search("rails-env").first.content,
                :revision => deploy.search("scm-revision").first.content,
                :local_username => deploy.search("local-username").first.content,
                :created_at => deploy.search("created-at").first.content,
                :ends_at => deploy.search("ends-at").first.content
              }
            }
          }

          local_response = $local_connection.post do |request|
            request.url "/airbrake/projects"
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

puts "Done. It took me %.03f seconds" % (Time.now - starting_time)
