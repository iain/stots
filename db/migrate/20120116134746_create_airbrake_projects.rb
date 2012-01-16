class CreateAirbrakeProjects < ActiveRecord::Migration
  def change
    create_table :airbrake_projects do |t|
      t.integer :project_id
      t.string :name
      t.integer :airbrake_id
      t.string :api_key

      t.timestamps
    end
  end
end
