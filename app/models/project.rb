class Project < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :iframes

  def self.list
    order(:name)
  end

  include Airbrake::ForProject

end
