class Airbrake::Error < ActiveRecord::Base

  validates_presence_of :airbrake_project_id, :group_id, :notice_id

  validates_uniqueness_of :notice_id

  def self.import(data)
    transaction do
      Array(data[:notices]).each do |notice|
        find_by = { :notice_id => notice[:id] }
        error = where(find_by).first || new(find_by)
        error.group_id            = data[:id]
        error.resolved            = data[:resolved].to_s == "true"
        error.airbrake_project_id = data[:project_id]
        error.error_message       = data[:error_message]
        error.occurred_at         = notice[:created_at]
        error.save!
      end
    end
  end

  def self.by_date
    group("date").select("COUNT(airbrake_errors.id) AS count, DATE(airbrake_errors.occurred_at) AS date")
  end

  def self.resolved(resolved)
    where(:resolved => resolved)
  end

end
