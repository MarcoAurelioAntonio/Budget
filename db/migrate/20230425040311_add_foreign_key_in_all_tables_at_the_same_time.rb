class AddForeignKeyInAllTablesAtTheSameTime < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "expenses", "users", column: "author_id"
    add_foreign_key "group_expenses", "expenses"
    add_foreign_key "group_expenses", "groups"
    add_foreign_key "groups", "users", column: "author_id"
  end
end
