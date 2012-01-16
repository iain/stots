class Airbrake::Error < ActiveRecord::Base

  validates_presence_of :airbrake_project_id, :group_id, :notice_id

  def self.import(data)
    data[:notices].each do |notice|
      error = where(:notice_id => notice[:id]).first || new(:notice_id => notice[:id])
      error.resolved = data[:resolved]
      error.airbrake_project_id = data[:project_id]
      error.error_message = data[:error_message]
      error.occurred_at = Time.parse(notice[:created_at])
      error.group_id = data[:id]
      error.save!
    end
  end

end
