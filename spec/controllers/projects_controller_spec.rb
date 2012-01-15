require 'spec_helper'

describe ProjectsController do

  describe "#index" do

    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

  end

  describe "#show" do

    let(:project) { stub("project") }
    let(:project_id) { "project_id" }

    before do
      Project.stub(:find).and_return(project)
    end

    it "finds the project" do
      Project.should_receive(:find).with(project_id)
      get :show, :id => project_id
    end

    it "renders the show template" do
      get :show, :id => project_id
      response.should render_template(:show)
    end

    it "assigns the project" do
      get :show, :id => project_id
      assigns(:project).should == project
    end

  end

end
