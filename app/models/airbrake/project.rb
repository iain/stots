class Airbrake::Project < ActiveRecord::Base

  belongs_to :project

  has_many :airbrake_errors,  :foreign_key => "airbrake_project_id", :class_name => "Airbrake::Error", :primary_key => :airbrake_id
  has_many :airbrake_deploys, :foreign_key => "airbrake_project_id", :class_name => "Airbrake::Deploy"

  def to_label
    "#{name} (##{airbrake_id})"
  end

  def self.import(data)
    transaction do
      project = where(:airbrake_id => data[:id]).first || new(:airbrake_id => data[:id])
      project.name = data[:name]
      project.api_key = data[:api_key]
      project.save!
      Array(data[:deploys]).each do |deploy|
        Airbrake::Deploy.import(project, deploy)
      end
    end
  end

  def self.list
    order(:name)
  end

end
