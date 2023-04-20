class RemoveFieldsFromFoods < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :quantity, :integer
    remove_column :foods, :user_id, :integer
  end
end
