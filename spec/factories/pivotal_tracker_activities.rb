# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pivotal_tracker_activities do
    pivotal_id 1
    project_id 1
    event_type "MyString"
    occurred_at "2012-01-18 23:38:47"
    author "MyString"
    description "MyText"
  end
end
