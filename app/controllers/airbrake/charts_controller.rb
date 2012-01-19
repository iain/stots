class Airbrake::ChartsController < ApplicationController

  def show
    project = Project.find(params[:project_id])
    render :json => Airbrake::Chart[project]
  end

end
