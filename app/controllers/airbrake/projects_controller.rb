class Airbrake::ProjectsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    Airbrake::Project.import(params[:project])
    head :ok
  end

end
