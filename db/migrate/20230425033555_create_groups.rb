class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :author_id
      t.string :name
      t.string :icon

      t.timestamps
    end
    add_index :groups, :author_id
  end
end
