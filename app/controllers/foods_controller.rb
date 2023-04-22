class FoodsController < ApplicationController
  before_action :authenticate_user!

  # Add it to bypass the authorization check of cancancan
  skip_authorization_check

  # GET /foods or /foods.json
  def index
    @foods = Food.all.order(created_at: :desc)
  end

  # GET /foods/1 or /foods/1.json
  def show
    @food = Food.find(params[:id])

    unless @food
      redirect_to foods_path, notice: "Food not found with id = #{params[:id]}"
    end
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
    @food = Food.find(params[:id])
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    @food = Food.find(params[:id])

    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])

    if @food
      @food.destroy
      redirect_to foods_path, notice: 'Food was successfully deleted.'
    else
      redirect_to foods_path, notice: "Food not found with id = #{params[:id]}"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
