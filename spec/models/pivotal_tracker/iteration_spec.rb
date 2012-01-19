require 'spec_helper'

describe PivotalTracker::Iteration do

  it { should belong_to :project }

  it { should validate_presence_of :project_id }
  it { should validate_presence_of :pivotal_id }

end
