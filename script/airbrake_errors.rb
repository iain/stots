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

puts "Getting error listing from Airbrake"

go_again = true

def get_errors(page = 1)

  groups = 0

  response = $connection.get do |request|
    request.url "/errors.xml"
    request.params[:auth_token] = KEY
    request.params[:page] = page
    request.params[:show_resolved] = true
  end

  response.on_complete do

    doc = Nokogiri::XML(response.body)

    groups = doc.search("//groups/group")

    puts "Got errors listing for #{groups.size} errors I'm now going to fetch."

    groups.each do |group|

      id = group.search("id").first.content

      res = $connection.get do |request|
        request.url "/errors/#{id}/notices.xml"
        request.params[:auth_token] = KEY
      end

      res.on_complete do

        puts "Got notices for #{id}"

        data = {
          :id => id,
          :resolved => group.search("resolved").first.content == "true",
          :project_id => group.search("project-id").first.content,
          :error_message => group.search("error-message").first.content,
          :notices => Nokogiri::XML(res.body).search("//notices/notice").map { |notice|
            {
              :id => notice.search("id").first.content,
              :created_at => notice.search("created-at").first.content
            }
          }
        }

        local_response = $local_connection.post do |request|
          request.url "/airbrake/errors"
          request.body = { :errors => data }
        end

        local_response.on_complete do

          puts "Handled notices for #{id}"

        end

      end

    end

    get_errors(page + 1) if groups.size == 30 && ENV["GET_MORE"] == "true"

  end

end


$connection.in_parallel(Typhoeus::Hydra.hydra) do
  $local_connection.in_parallel(Typhoeus::Hydra.hydra) do
    get_errors
  end
end

puts "Done. It took me %.03f seconds" % (Time.now - starting_time)
