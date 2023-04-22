require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'Admin', email: 'admin@admin.com', password: '123456') }
  let(:recipe) { Recipe.create(
    name: 'Carrot Soup',
    user_id: user.id,
    prep_time: 3.hours,
    cook_time: 1.hours,
    public: true)
  }
  let(:food) { Food.create(name: 'Apple', price: 0.5, measurement_unit: 'kg') }
  let(:recipe_food) { RecipeFood.new(recipe:, food:, quantity: 10) }

  describe 'validations' do
    it 'requires a quantity' do
      invalid_recipe_food = RecipeFood.new(quantity: nil, recipe:, food:)

      expect(invalid_recipe_food).to_not be_valid
    end

    it 'requires the quantity to be a number greater than or equal to 0' do
      invalid_recipe_food = RecipeFood.new(quantity: -1, recipe:, food:)

      expect(invalid_recipe_food).to_not be_valid
    end

    it 'requires an recipe' do
      invalid_recipe_food = RecipeFood.new(quantity: 10, food:)

      expect(invalid_recipe_food).to_not be_valid
    end

    it 'requires a food id' do
      invalid_recipe_food = RecipeFood.new(quantity: 10, recipe:)

      expect(invalid_recipe_food).to_not be_valid
    end

    it 'is valid with all required attributes' do
      recipe_food = RecipeFood.new(quantity: 10, recipe:, food:)

      expect(recipe_food).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an recipe' do
      expect(recipe_food.recipe).to eql(recipe)
    end

    it 'belongs to an food' do
      expect(recipe_food.food).to eql(food)
    end
  end
end
