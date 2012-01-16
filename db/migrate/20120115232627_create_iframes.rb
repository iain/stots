class CreateIframes < ActiveRecord::Migration
  def change
    create_table :iframes do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.integer :project_id

      t.timestamps
    end
    add_index :iframes, :slug
    add_index :iframes, :project_id
  end
end
