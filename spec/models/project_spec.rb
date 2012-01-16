require 'spec_helper'

describe Project do

  it { should have_many(:iframes) }

  it { should validate_presence_of(:name) }

  specify do
    create :project
    should validate_uniqueness_of(:name).case_insensitive
  end

  it "finds by slug" do
    project = create :project, :name => "Pretty title"
    Project.find("pretty-title").should == project
  end

end
