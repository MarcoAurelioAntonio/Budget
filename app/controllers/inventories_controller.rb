class InventoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @inventories = @user.inventory
  end
end
