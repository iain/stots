class CreateAirbrakeErrors < ActiveRecord::Migration
  def change
    create_table :airbrake_errors do |t|

      t.integer :airbrake_project_id, :null => false
      t.integer :group_id, :null => false
      t.integer :notice_id, :null => false

      t.text :error_message
      t.boolean :resolved, :default => false
      t.datetime :occurred_at

      t.timestamps
    end

    add_index :airbrake_errors, :airbrake_project_id
    add_index :airbrake_errors, :notice_id
    add_index :airbrake_errors, :group_id

  end
end
