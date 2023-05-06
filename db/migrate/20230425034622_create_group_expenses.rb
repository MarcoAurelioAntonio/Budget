class CreateGroupExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :group_expenses do |t|
      t.integer :group_id
      t.integer :expense_id

      t.timestamps
    end
    add_index :group_expenses, :group_id
    add_index :group_expenses, :expense_id
  end
end
