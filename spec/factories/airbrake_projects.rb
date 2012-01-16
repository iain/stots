# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :airbrake_project do
    project_id 1
    name "MyString"
    airbrake_id 1
    api_key "MyString"
  end
end
