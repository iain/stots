require 'spec_helper'

describe Settings do

  it_should_behave_like ActiveModel

  let!(:setting) { create :setting, :group => "foo", :key => "bar", :value => "quux" }

  it "knows the value of the setting" do
    subject.foo_bar.should == "quux"
  end

  it "will update values of settings" do
    expect {
      subject.save(setting.id => { :value => "baz" })
    }.to change {
      setting.reload.value
    }.from("quux").to("baz")
  end

  it "will help build a form" do
    names = []
    ids = []
    fields = []
    subject.each do |group|
      names << group.name
      group.each do |id, field|
        ids << id
        fields << field
      end
    end
    names.should == [ "foo" ]
    ids.should == [ "foo_bar" ]
    fields.should == [ "settings[#{setting.id}][value]" ]
  end

end
