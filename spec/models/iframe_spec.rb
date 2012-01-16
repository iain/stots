require 'spec_helper'

describe Iframe do

  it { should belong_to(:project) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:project_id) }

  specify do
    create :iframe
    should validate_uniqueness_of(:name).scoped_to(:project_id).case_insensitive
  end

  specify do
    create :iframe
    should validate_uniqueness_of(:url).case_insensitive
  end

  it "finds by slug" do
    iframe = create :iframe, :name => "Pretty title"
    Iframe.find("pretty-title").should == iframe
  end

end
