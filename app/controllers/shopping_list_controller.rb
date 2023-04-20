class ShoppingListController < ApplicationController
  def index
    # URL params from recipe/show
    recipe_id = 1 #params[:recipe_id]
    inventory_id = 2 # params[:inventory_id]

    # Lógic to the list
    

    # View rendering
    render :index
  end
end
