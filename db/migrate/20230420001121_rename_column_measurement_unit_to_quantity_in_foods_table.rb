class RenameColumnMeasurementUnitToQuantityInFoodsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :measurement_unit, :quantity
  end
end
