# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :error do
    airbrake_project_id 1
    error_message "MyText"
    resolved false
    notice_id 1
    occurred_at "2012-01-16 17:50:47"
    group_id 1
  end
end
