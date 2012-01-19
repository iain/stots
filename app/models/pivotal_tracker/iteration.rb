class PivotalTracker::Iteration < ActiveRecord::Base

  belongs_to :project, :class_name => "PivotalTracker::Project", :foreign_key => "pivotal_id"

  validates_presence_of :pivotal_id

  def self.import(project, data)
    iteration = where(:pivotal_id => data[:id]).first || new(:pivotal_id => data[:id])
    iteration.project_id = project.pivotal_id
    iteration.number = data[:number]
    iteration.start = data[:start]
    iteration.finish = data[:finish]
    iteration.team_strength = data[:team_strength]
    iteration.stories = data[:stories]
    iteration.save!
  end


end
