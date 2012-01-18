class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.string :key
      t.string :group
      t.string :value

      t.timestamps
    end
    add_index :settings, :key
    add_index :settings, :group
  end

  def down
    drop_table :settings
  end
end
