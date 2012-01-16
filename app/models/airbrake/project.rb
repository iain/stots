class Airbrake::Project < ActiveRecord::Base
  belongs_to :project

  has_many :airbrake_errors, :foreign_key => "airbrake_project_id", :primary_key => :airbrake_id

  def to_label
    "#{name} (##{airbrake_id})"
  end

  def self.import(data)
    project = where(:airbrake_id => data[:id]).first || new(:airbrake_id => data[:id])
    project.name = data[:name]
    project.api_key = data[:api_key]
    project.save!
  end

end
