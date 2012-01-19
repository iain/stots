class PivotalTracker::ProjectsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    PivotalTracker::Project.import(params[:project])
    head :ok
  end

end
