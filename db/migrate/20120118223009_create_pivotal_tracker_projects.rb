class CreatePivotalTrackerProjects < ActiveRecord::Migration
  def change
    create_table :pivotal_tracker_projects do |t|
      t.string :name
      t.integer :pivotal_id
      t.integer :project_id
      t.integer :iteration_length
      t.string :week_start_day
      t.string :point_scale
      t.integer :current_velocity
      t.integer :initial_velocity

      t.timestamps
    end
    add_index :pivotal_tracker_projects, :pivotal_id
    add_index :pivotal_tracker_projects, :project_id
  end
end
