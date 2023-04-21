class ShoppingListController < ApplicationController
  skip_authorization_check only: :index
  def index
    # URL params from recipe/show to http://localhost:3000/shopping_list?recipe_id=1&inventory_id=1
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])

    # Create the `recipe` hash with recipe data
    recipe = {
      'Carrot' => { quantity: 2, price: 0.5 }
    }

    recipe = @recipe.recipe_foods.to_h { |recipe_food| [recipe_food.food.name, { quantity: recipe_food.quantity, price: recipe_food.food.price }] }

    # Create the `inventory` hash with inventory data
    inventory = {
      'Carrot' => 4,
      'Tomato' => 1
    }

    inventory = @inventory.inventory_foods.to_h { |inventory_food| [inventory_food.food.name, inventory_food.quantity] }
    puts recipe
    puts inventory
    # Initialize hash to store shopping list data
    shopping_list_data = {}

    # Iterate over recipe foods to determine how much of each is needed
    recipe.each do |food_name, recipe_data|
      # Calculate quantity needed
      quantity_needed = recipe_data[:quantity] - inventory[food_name]

      # Add food to shopping list if quantity needed is positive
      next unless quantity_needed.positive?

      shopping_list_data[food_name] = {
        quantity_needed:,
        price_per_unit: recipe_data[:price],
        total_price: quantity_needed * recipe_data[:price]
      }
    end

    @total_food_to_buy = shopping_list_data.values.sum { |data| data[:quantity_needed] }
    @total_value_needed = shopping_list_data.values.sum { |data| data[:total_price] }

    @shopping_list_data = shopping_list_data
  end
end
