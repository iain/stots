class ChartsController < ApplicationController

  def show
    project = Project.find(params[:project_id])
    render :json => Charts::Errors[project]
  end

end
