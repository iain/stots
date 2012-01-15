class ProjectsController < ApplicationController

  def index
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => Charts::Overview[@project] }
    end
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, :notice => "Project was created"
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to :back, :notice => "Project updated"
    else
      flash.now[:alert] = "Project could not be updated"
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to root_url
  end

end
