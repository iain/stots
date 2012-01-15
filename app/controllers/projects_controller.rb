class ProjectsController < ApplicationController

  def index
  end

  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => Charts::Overview[@project] }
    end
  end

end
