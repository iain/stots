class ErrorsController < InheritedResources::Base
  belongs_to :project
  defaults :resource_class => Airbrake::Error, :collection_name => 'airbrake_errors', :instance_name => 'airbrake_error'
end
