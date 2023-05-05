# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


authors = User.create!([
  {name: 'SpongeBob', email: 'spongebob@friend.com', password: 'squarepants'},
  {name: 'Patrick', email: 'patrick@friend.com', password: 'patrick'},
  {name: 'Squidward', email: 'squidward@friend.com', password: 'squidward'},
  {name: 'Mr. Krabs', email: 'krabs@friend.com', password: 'krabs1'},
  {name: 'Plankton', email: 'plankton@foe.com', password: 'plankton'},
  {name: 'Sandy', email: 'sandy@friend.com', password: 'sandy1'},
  {name: 'Mrs. Puff', email: 'puff@friend.com', password: 'puff11'},
  {name: 'Pearl', email: 'pearl@friend.com', password: 'pearl1'},
  {name: 'Gary', email: 'gary@friend.com', password: 'gary11'},
])

categories = Group.create!([
  {author: authors[0], name: 'Movies', icon: 'https://cdn-icons-png.flaticon.com/512/3163/3163478.png'},
  {author: authors[0], name: 'Food', icon: 'https://cdn-icons-png.flaticon.com/512/706/706164.png'},
  {author: authors[0], name: 'Clothes', icon: 'https://cdn-icons-png.flaticon.com/512/2230/2230876.png'},
  {author: authors[0], name: 'Travel', icon: 'https://cdn-icons-png.flaticon.com/512/2200/2200326.png'},
  {author: authors[1], name: 'Books', icon: 'https://cdn-icons-png.flaticon.com/512/3389/3389081.png'},
  {author: authors[1], name: 'Food', icon: 'https://cdn-icons-png.flaticon.com/512/706/706164.png'},
  {author: authors[1], name: 'Clothes', icon: 'https://cdn-icons-png.flaticon.com/512/2230/2230876.png'},
  {author: authors[2], name: 'Travel', icon: 'https://cdn-icons-png.flaticon.com/512/2200/2200326.png'},
  {author: authors[3], name: 'Movies', icon: 'https://cdn-icons-png.flaticon.com/512/3163/3163478.png'},
])

expenses = Expense.create!([
  {author: authors[0], name: 'Avengers: Infinity', amount: 1.01, groups: [categories[0]]},
  {author: authors[0], name: 'Avengers: Endgame', amount: 10.02, groups: [categories[0]]},
  {author: authors[0], name: 'Avengers: Age of Ultron', amount: 100.03, groups: [categories[0]]},
  {author: authors[0], name: 'Groceries', amount: 1.04, groups: [categories[1]]},
  {author: authors[0], name: 'Pizza', amount: 4, groups: [categories[1]]},
  {author: authors[0], name: 'Drinks', amount: 5.9, groups: [categories[1]]},
  {author: authors[0], name: 'Tomatoes', amount: 15, groups: [categories[1]]},
])
