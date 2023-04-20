class InventoryFoodsController < ApplicationController
  before_action :authenticate_user!

  skip_authorization_check

  def new
    puts params
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.build
  end
end
