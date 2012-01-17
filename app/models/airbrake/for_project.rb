module Airbrake::ForProject

  def self.included(project)
    project.has_one :airbrake_project, :class_name => "Airbrake::Project"
    project.has_many :airbrake_errors, :through => :airbrake_project, :class_name => "Airbrake::Error"
    project.has_many :airbrake_deploys, :through => :airbrake_project, :class_name => "Airbrake::Deploy"
  end

  def airbrake_project_id
    airbrake_project.try(:id)
  end

  def airbrake_project_id=(id)
    self.airbrake_project = Airbrake::Project.find_by_id(id)
  end

end
