class InventoryFoodsController < ApplicationController
  before_action :authenticate_user!

  skip_authorization_check

  def new
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.build
  end

  def create
    @inventory = Inventory.find(params[:inventory_id])

    @food = Food.find(params[:inventory_food][:food_id])
    @quantity = params[:inventory_food][:quantity].to_i

    existing_inventory_food = @inventory.inventory_foods.find_by(food_id: @food.id)

    if existing_inventory_food
      existing_inventory_food.update(quantity: existing_inventory_food.quantity + @quantity)
      redirect_to inventory_path(@inventory), notice: 'Food quantity updated successfully!'
    else
      @inventory_food = @inventory.inventory_foods.build(food: @food, quantity: @quantity)

      if current_user
        if @inventory.user == current_user
          @inventory_food.save
          redirect_to inventory_path(@inventory), notice: 'Food added successfully!'
        else
          redirect_to inventories_path, notice: "You don't have permission to add food to this inventory."
        end
      else
        redirect_to new_user_session_path, notice: 'Please sign in to add food to the inventory.'
      end
    end
  end

  def destroy
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.find_by(id: params[:id])
    if current_user
      if @inventory_food.nil?
        redirect_to inventory_path(@inventory), notice: 'Food not found.'
      elsif @inventory.user != current_user
        redirect_to inventories_path, notice: "You don't have permission to delete food from this inventory."
      else
        @inventory_food.destroy
        redirect_to inventory_path(@inventory), notice: 'Food deleted successfully.'
      end
    else
      redirect_to new_user_session_path, notice: 'Please sign in to destroy food to the inventory.'
    end
  end
end
