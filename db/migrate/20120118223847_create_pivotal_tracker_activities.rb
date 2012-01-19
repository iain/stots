class CreatePivotalTrackerActivities < ActiveRecord::Migration
  def change
    create_table :pivotal_tracker_activities do |t|
      t.integer :pivotal_id
      t.integer :project_id
      t.string :event_type
      t.datetime :occurred_at
      t.string :author
      t.text :description

      t.timestamps
    end
    add_index :pivotal_tracker_activities, :pivotal_id
    add_index :pivotal_tracker_activities, :project_id
  end
end
