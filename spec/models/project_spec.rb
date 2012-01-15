require 'spec_helper'

describe Project do

  it { should validate_presence_of(:name) }

  it "finds by slug" do
    project = Factory :project, :name => "Pretty title"
    Project.find("pretty-title").should == project
  end

end
