require 'spec_helper'

describe Setting do

  describe "#group" do
    it { should validate_presence_of :group }
  end

  describe "#key" do
    it { should validate_presence_of :key }
    specify do
      create :setting
      should validate_uniqueness_of(:key).case_insensitive.scoped_to(:group)
    end
  end

end
