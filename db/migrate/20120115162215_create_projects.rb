class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :projects, :slug
  end
end
