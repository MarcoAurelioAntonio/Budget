class ShoppingListController < ApplicationController
  def index
    # URL params from recipe/show
    recipe_id = params[:recipe_id]
    inventory_id = params[:inventory_id]

    # Lógic to the list
    

    # View rendering
    render :index
  end
end
