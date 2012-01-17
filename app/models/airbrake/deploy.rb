class Airbrake::Deploy < ActiveRecord::Base

  belongs_to :airbrake_project, :class_name => "Airbrake::Project"

  validates_presence_of :airbrake_project_id

  def self.import(project, deploys)
    deploys.each do |data|
      deploy = where(:airbrake_id => data[:id]).first || new(:airbrake_id => data[:id])
      deploy.rails_env = data[:rails_env]
      deploy.revision = data[:revision]
      deploy.local_username = data[:local_username]
      deploy.deployed_at = data[:created_at]
      deploy.ends_at = data[:ends_at]
      deploy.airbrake_project = project
      deploy.save!
    end
  end

end
