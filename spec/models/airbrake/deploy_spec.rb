require 'spec_helper'

describe Airbrake::Deploy do

  it { should belong_to :airbrake_project }

  it { should validate_presence_of :airbrake_project_id }

end
