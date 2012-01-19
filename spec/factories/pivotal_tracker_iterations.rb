# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pivotal_tracker_iterations do
    pivotal_id 1
    project_id 1
    start "2012-01-18 23:34:06"
    finish "2012-01-18 23:34:06"
    team_strength 1.5
    stories 1
  end
end
