class InventoriesController < ApplicationController
  before_action :authenticate_user!

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

  def new; end

  def create; end

  def destroy; end
end
