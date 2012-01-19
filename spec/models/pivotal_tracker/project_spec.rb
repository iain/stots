require 'spec_helper'

describe PivotalTracker::Project do

  it { should belong_to :project }

  it { should have_many :iterations }
  it { should have_many :activities }

  it { should validate_presence_of :pivotal_id }
  it { should validate_presence_of :name }

end
