require 'spec_helper'

describe Airbrake::Error do

  it { should validate_presence_of :airbrake_project_id }
  it { should validate_presence_of :group_id }
  it { should validate_presence_of :notice_id }

end
