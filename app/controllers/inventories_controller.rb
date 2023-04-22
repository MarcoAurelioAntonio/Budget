class InventoriesController < ApplicationController
  before_action :authenticate_user!

  # Add it to bypass the authorization check of cancancan
  skip_authorization_check

  def index
    @user = current_user
    @inventories = @user.inventory
  end

  def show
    @inventory = Inventory.find_by(id: params[:id])

    if @inventory
      if @inventory.user != current_user
        redirect_to inventories_path, notice: 'You are not authorized to view this inventory.'
      end
      @user = @inventory.user
    else
      redirect_to inventories_path, notice: "Inventory not found with id = #{params[:id]}"
    end
  end

  def new
    @user = current_user
    @inventory = @user.inventory.new
  end

  def create
    @user = current_user
    @inventory = @user.inventory.new(inventory_params)

    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @inventory = Inventory.find_by(id: params[:id])

    if @inventory
      if @inventory.user == current_user
        @inventory.destroy
        redirect_to inventories_path, notice: 'Inventory was successfully deleted.'
      else
        redirect_to inventories_path, notice: 'You are not authorized to delete this inventory.'
      end
    else
      redirect_to inventories_path, notice: "Inventory not found with id = #{params[:id]}"
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
