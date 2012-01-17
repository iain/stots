# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deploy do
    airbrake_project_id 1
    airbrake_id 1
    rails_env "MyString"
    revision "MyString"
    local_username "MyString"
    deployed_at "2012-01-17 19:43:12"
    ends_at "2012-01-17 19:43:12"
  end
end
