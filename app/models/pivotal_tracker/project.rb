class PivotalTracker::Project < ActiveRecord::Base

  belongs_to :project

  has_many :iterations, :foreign_key => "project_id", :primary_key => "pivotal_id", :class_name => "PivotalTracker::Iteration"
  has_many :activities, :foreign_key => "project_id", :primary_key => "pivotal_id", :class_name => "PivotalTracker::Activity"

  validates_presence_of :pivotal_id, :name

  def self.import(data)
    transaction do
      project = where(:pivotal_id => data[:id]).first || new(:pivotal_id => data[:id])
      project.name = data[:name]
      project.iteration_length = data[:iteration_length]
      project.week_start_day = data[:week_start_day]
      project.point_scale = data[:point_scale]
      project.current_velocity = data[:current_velocity]
      project.initial_velocity = data[:initial_velocity]
      project.save!
      data[:iterations].each do |iteration|
        PivotalTracker::Iteration.import(project, iteration)
      end
      data[:activities].each do |activity|
        PivotalTracker::Activity.import(project, activity)
      end
    end
  end

  def self.list
    order(:name)
  end

  def to_label
    "#{name} (#{pivotal_id})"
  end

end
