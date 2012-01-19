module PivotalTracker::ForProject

  def self.included(project)
    project.has_one :pivotal_tracker_project, :class_name => "PivotalTracker::Project"
    project.has_many :pivotal_tracker_activities, :through => :pivotal_tracker_project, :class_name => "PivotalTracker::Activity", :source => :activities
    project.has_many :pivotal_tracker_iterations, :through => :pivotal_tracker_project, :class_name => "PivotalTracker::Iteration", :source => :iterations
  end

  def pivotal_tracker_project_id
    pivotal_tracker_project.try(:id)
  end

  def pivotal_tracker_project_id=(id)
    self.pivotal_tracker_project = PivotalTracker::Project.find_by_id(id)
  end

end
