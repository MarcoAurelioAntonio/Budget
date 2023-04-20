# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# crea 15 alimentos con datos aleatorios
30.times do
  name = Faker::Food.dish
  quantity = rand(1.0..10.0).round(2)
  price = rand(1.0..10.0).round(2)
  Food.create!(name: name, quantity: quantity, price: price)
  end
