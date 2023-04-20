class AddForeignKeyAndIndexToFoods < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :foods, :users, column: :user_id
  end
end
