class CreatePivotalTrackerIterations < ActiveRecord::Migration
  def change
    create_table :pivotal_tracker_iterations do |t|
      t.integer :pivotal_id
      t.integer :project_id
      t.integer :number
      t.datetime :start
      t.datetime :finish
      t.float :team_strength
      t.integer :stories

      t.timestamps
    end
    add_index :pivotal_tracker_iterations, :pivotal_id
    add_index :pivotal_tracker_iterations, :project_id
  end
end
