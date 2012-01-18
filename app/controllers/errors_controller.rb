class ErrorsController < InheritedResources::Base

  belongs_to :project
  defaults :resource_class => Airbrake::Error, :collection_name => 'airbrake_errors', :instance_name => 'airbrake_error'
  has_scope :page, :default => 1

  private


  def collection
    @airbrake_errors ||= super.order("occurred_at DESC")
  end

end
