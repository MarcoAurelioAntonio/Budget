require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'shahadat@example.com', password: '12345678') }
  let(:inventory) { Inventory.create(name: 'My Inventory', user:) }
  let(:food) { Food.create(name: 'Apple', measurement_unit: 'piece', price: 0.5, quantity: 10, user_id: user.id) }
  let(:inventory_food) { InventoryFood.new(quantity: 10, inventory:, food:) }

  describe 'validations' do
    it 'requires a quantity' do
      invalid_inventory_food = InventoryFood.new(quantity: nil, inventory:, food:)

      expect(invalid_inventory_food).to_not be_valid
    end

    it 'requires the quantity to be a number greater than or equal to 0' do
      invalid_inventory_food = InventoryFood.new(quantity: -1, inventory:, food:)

      expect(invalid_inventory_food).to_not be_valid
    end

    it 'requires an inventory' do
      invalid_inventory_food = InventoryFood.new(quantity: 10, food:)

      expect(invalid_inventory_food).to_not be_valid
    end

    it 'requires a food id' do
      invalid_inventory_food = InventoryFood.new(quantity: 10, inventory:)

      expect(invalid_inventory_food).to_not be_valid
    end

    it 'is valid with all required attributes' do
      inventory_food = InventoryFood.new(quantity: 10, inventory:, food:)

      expect(inventory_food).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an inventory' do
      expect(inventory_food.inventory).to eql(inventory)
    end

    it 'belongs to an food' do
      expect(inventory_food.food).to eql(food)
    end
  end
end
