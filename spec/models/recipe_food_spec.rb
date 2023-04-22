require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'shahadat@example.com', password: '12345678') }
  let(:recipe) do
    Recipe.create(name: 'Recipe name', user:, prep_time: rand(5..50).minutes, cook_time: rand(5..50).minutes,
                  description: 'Recipe Description', public: false)
  end
  let(:food) { Food.create(name: 'Apple', price: 0.5) }

  describe 'validations' do
    it 'requires a recepe' do
      recipe_food = RecipeFood.new(food:, quantity: 1.5)

      expect(recipe_food).not_to be_valid
    end

    it 'requires a food' do
      recipe_food = RecipeFood.new(recipe:, quantity: 1.5)

      expect(recipe_food).not_to be_valid
    end

    it 'requires a quantity' do
      recipe_food = RecipeFood.new(recipe:, food:)

      expect(recipe_food).not_to be_valid
    end

    it 'requires a non negative quantity' do
      recipe_food = RecipeFood.new(recipe:, food:, quantity: -1.5)

      expect(recipe_food).not_to be_valid
    end

    it 'is valid with all required attributes' do
      recipe_food = RecipeFood.new(recipe:, food:, quantity: 1.5)

      expect(recipe_food).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an recipe' do
      recipe_food = RecipeFood.new(recipe:, food:, quantity: 1.5)

      expect(recipe_food.recipe).to eql(recipe)
    end

    it 'belongs to an food' do
      recipe_food = RecipeFood.new(recipe:, food:, quantity: 1.5)

      expect(recipe_food.food).to eql(food)
    end
  end
end
