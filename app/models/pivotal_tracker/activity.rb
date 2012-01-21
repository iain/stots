class PivotalTracker::Activity < ActiveRecord::Base

  belongs_to :project, :class_name => "PivotalTracker::Project", :foreign_key => "pivotal_id"

  validates_presence_of :pivotal_id, :project_id

  def self.import(project, data)
    activity = where(:pivotal_id => data[:id]).first || new(:pivotal_id => data[:id])
    activity.project_id   = project.pivotal_id
    activity.event_type   = data[:event_type]
    activity.occurred_at  = data[:occurred_at]
    activity.author       = data[:author]
    activity.description  = data[:description]
    activity.save!
  end

end
