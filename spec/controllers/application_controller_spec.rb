require 'spec_helper'

describe ApplicationController do

  describe "#projects" do

    it "gets all projects" do
      Project.should_receive(:list)
      controller.projects
    end

  end

end
