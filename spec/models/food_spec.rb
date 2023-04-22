require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    it 'requires a food name' do
      food = Food.create(name: '', measurement_unit: 'kg', price: 76)

      expect(food).to_not be_valid
    end

    it 'requires a measurement unit' do
      food = Food.create(name: 'Food 1', price: 76)

      expect(food).to_not be_valid
    end

    it 'is valid with all required attributes' do
      food = Food.create(name: 'Food 1', measurement_unit: 'kg', price: 76)

      expect(food).to be_valid
    end
  end
end
