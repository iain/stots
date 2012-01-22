class ChangeNoticeIdForAirbrakeErrors < ActiveRecord::Migration
  def up
    change_column :airbrake_errors, :notice_id, :string, :length => 255
  end

  def down
    change_column :airbrake_errors, :notice_id, :integer
  end
end
