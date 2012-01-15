class Project < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.list
    order(:name)
  end

end
