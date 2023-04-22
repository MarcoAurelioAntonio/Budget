require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'shahadat@example.com', password: '12345678') }

  describe 'validations' do
    it 'requires a inventory name' do
      recipe = Recipe.create(name: '', user:, prep_time: rand(5..50).minutes,
                             cook_time: rand(5..50).minutes, description: 'Recipe Description', public: false)

      expect(recipe).to_not be_valid
    end

    it 'requires a user' do
      recipe = Recipe.create(name: 'Recipe name', prep_time: rand(5..50).minutes,
                             cook_time: rand(5..50).minutes, description: 'Recipe Description', public: false)

      expect(recipe).to_not be_valid
    end

    it 'requires a prep_time' do
      recipe = Recipe.create(name: 'Recipe name', user:, prep_time: '',
                             cook_time: rand(5..50).minutes, description: 'Recipe Description', public: false)

      expect(recipe).to_not be_valid
    end

    it 'requires a cook_time' do
      recipe = Recipe.create(name: 'Recipe name', user:, prep_time: rand(5..50).minutes,
                             cook_time: '', description: 'Recipe Description', public: false)

      expect(recipe).to_not be_valid
    end

    it 'requires a description' do
      recipe = Recipe.create(name: 'Recipe name', user:, prep_time: rand(5..50).minutes,
                             cook_time: rand(5..50).minutes, description: '', public: false)

      expect(recipe).to_not be_valid
    end

    it 'does not requires a public status' do
      recipe = Recipe.create(name: 'Recipe name', user:, prep_time: rand(5..50).minutes,
                             cook_time: rand(5..50).minutes, description: 'Recipe Description')

      expect(recipe).to be_valid
    end

    it 'is valid with all required attributes' do
      recipe = Recipe.create(name: 'Recipe name', user:, prep_time: rand(5..50).minutes,
                             cook_time: rand(5..50).minutes, description: 'Recipe Description', public: false)

      expect(recipe).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an user' do
      recipe = Recipe.create(name: 'Recepe name', user:, prep_time: rand(5..50).minutes,
                             cook_time: rand(5..50).minutes, description: 'Recepe Description', public: false)

      expect(recipe.user).to eql(user)
    end
  end
end
