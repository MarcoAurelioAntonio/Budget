class ShoppingListController < ApplicationController
  skip_authorization_check only: :index
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])

    recipe = @recipe.recipe_foods.to_h do |recipe_food|
      [recipe_food.food.name, { quantity: recipe_food.quantity, price: recipe_food.food.price }]
    end

    inventory = @inventory.inventory_foods.to_h { |inventory_food| [inventory_food.food.name, inventory_food.quantity] }

    shopping_list_data = calculate_shopping_list_data(recipe, inventory)

    @total_food_to_buy = shopping_list_data.values.sum { |data| data[:quantity_needed] }
    @total_value_needed = shopping_list_data.values.sum { |data| data[:total_price] }
    @shopping_list_data = shopping_list_data
  end

  def calculate_shopping_list_data(recipe, inventory)
    shopping_list_data = {}

    recipe.each do |food_name, recipe_data|
      quantity_needed = recipe_data[:quantity] - (inventory[food_name].nil? ? 0 : inventory[food_name])
      next unless quantity_needed.positive?

      shopping_list_data[food_name] = {
        quantity_needed:,
        price_per_unit: recipe_data[:price],
        total_price: quantity_needed * recipe_data[:price]
      }
    end

    shopping_list_data
  end
end
