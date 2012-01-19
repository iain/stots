# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pivotal_tracker_project do
    name "MyString"
    pivotal_id 1
    iteration_length 1
    week_start_day "MyString"
    point_scale "MyString"
    current_velicity 1
    initial_velocity 1
  end
end
