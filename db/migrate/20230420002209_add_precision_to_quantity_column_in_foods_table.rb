class AddPrecisionToQuantityColumnInFoodsTable < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :foods, :quantity, :decimal, precision: 10, scale: 2, using: 'quantity::decimal(10,2)'
    end
  
    def down
      change_column :foods, :quantity, :string
    end
  end
end
