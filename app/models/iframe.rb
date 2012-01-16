class Iframe < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :project_id

  validates_presence_of :url
  validates_uniqueness_of :url

  validates_presence_of :project_id

  belongs_to :project

  def self.list
    order(:name)
  end

end
