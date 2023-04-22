require 'faker'

# Delete existing data
RecipeFood.delete_all
InventoryFood.delete_all
Recipe.delete_all
Food.delete_all
Inventory.delete_all
User.delete_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('inventories')
ActiveRecord::Base.connection.reset_pk_sequence!('foods')
ActiveRecord::Base.connection.reset_pk_sequence!('recipes')
ActiveRecord::Base.connection.reset_pk_sequence!('inventory_foods')
ActiveRecord::Base.connection.reset_pk_sequence!('recipe_foods')


# Seed Users
users = []
5.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    confirmed_at: Time.now
  )
  users << user
end

# Seed Inventories
inventories = []
users.each do |user|
  rand(3..5).times do
    inventory = user.inventory.create(name: Faker::Commerce.department)
    inventories << inventory
  end
end

# Seed Foods
foods = []

20.times do
  food = Food.create(
    name: Faker::Food.ingredient,
    measurement_unit: Faker::Food.measurement.split(' ', 2)[1],
    price: Faker::Number.between(from: 1, to: 100)
  )
  foods << food
end

# Seed Inventory Foods
inventories.each do |inventory|
  rand(3..6).times do
    inventory_food = InventoryFood.create(
      quantity: Faker::Number.between(from: 1, to: 10),
      inventory_id: inventory.id,
      food_id: foods.sample.id
    )
  end
end

# Seed Recipes
recipes = []

users.each do |user|
  rand(3..5).times do
    recipe = user.recipes.create(
      name: Faker::Food.dish,
      prep_time: rand(5..50).minutes,
      cook_time: rand(5..50).minutes,
      description: Faker::Food.description,
      public: Faker::Boolean.boolean
    )
    recipes << recipe
  end
end

# Seed Recipe Foods.
recipe_foods = []

recipes.each do |recipe|
  rand(3..6).times do
    recipe_food = RecipeFood.create(
      quantity: Faker::Number.between(from: 1, to: 10),
      food_id: foods.sample.id,
      recipe_id: recipe.id
    )
    puts recipe_food.attributes
    recipe_foods << recipe_food
  end
end
