# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# crea 15 alimentos con datos aleatorios
# 30.times do
#   name = Faker::Food.dish
#   quantity = rand(1.0..10.0).round(2)
#   price = rand(1.0..10.0).round(2)
#   Food.create!(name: name, quantity: quantity, price: price)
#   end

user = User.create(
  name: 'Admin',
  email: 'admin@admin.com',
  password: 'password'
)

inv = Inventory.create(
  name: 'Home',
  user_id: user.id
)

food = Food.create(
  name: 'Carrot',
  measurement_unit: 'kg',
  price: 0.5
)

food2 = Food.create(
  name: 'Tomato',
  measurement_unit: 'kg',
  price: 1.5
)

InventoryFood.create(
  inventory_id: inv.id,
  food_id: food.id,
  quantity: 4
)

InventoryFood.create(
  inventory_id: inv.id,
  food_id: food2.id,
  quantity: 5
)

rec = Recipe.create(
  name: 'Carrot Soup',
  user_id: user.id,
  prep_time: 3.hours,
  cook_time: 1.hours,
  public: true
)

rec_food1 = RecipeFood.create(
  recipe_id: rec.id,
  food_id: food.id,
  quantity: 10
)

rec_food2 = RecipeFood.create(
  recipe_id: rec.id,
  food_id: food2.id,
  quantity: 20
)




