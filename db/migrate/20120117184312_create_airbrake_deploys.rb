class CreateAirbrakeDeploys < ActiveRecord::Migration
  def change
    create_table :airbrake_deploys do |t|
      t.integer :airbrake_project_id
      t.integer :airbrake_id
      t.string :rails_env
      t.string :revision
      t.string :local_username
      t.datetime :deployed_at
      t.datetime :ends_at

      t.timestamps
    end
    add_index :airbrake_deploys, :airbrake_project_id
  end
end
