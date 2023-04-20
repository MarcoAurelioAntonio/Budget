class RecipesController < ApplicationController
  # before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index]

  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
    # @recipes = Recipe.all
    if request.path == '/public_recipes'
      @recipes = @recipes.where(public: true)
      @recipe_display = 'public'

    elsif request.path == '/recipes' && user_signed_in?
      @recipes = @recipes.where(user_id: current_user)
      @recipe_display = 'user_owned'
    else
      redirect_to public_recipes_path
    end
    @recipes.each { |recipe| puts recipe.id }
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    # @recipe = Recipe.new
    # @recipe.user_id = current_or_guest_user.id
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    # @recipe = current_or_guest_user.recipes.new(recipe_params)
    @recipe.user_id = current_or_guest_user.id
    puts 'Aquí recipe'
    puts @recipe
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    cook_time = ActiveSupport::Duration
      .parse("PT#{params['recipe']['ck_time(4i)']}H#{params['recipe']['ck_time(5i)']}M")
    prep_time = ActiveSupport::Duration
      .parse("PT#{params['recipe']['pp_time(4i)']}H#{params['recipe']['pp_time(5i)']}M")
    delete_inneccesary_params
    params[:recipe]['prep_time'] = prep_time
    params[:recipe]['cook_time'] = cook_time
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :description, :public)
  end

  def delete_inneccesary_params
    params['recipe'].delete('pp_time(1i)')
    params['recipe'].delete('pp_time(2i)')
    params['recipe'].delete('pp_time(3i)')
    params['recipe'].delete('pp_time(4i)')
    params['recipe'].delete('pp_time(5i)')
    params['recipe'].delete('ck_time(1i)')
    params['recipe'].delete('ck_time(2i)')
    params['recipe'].delete('ck_time(3i)')
    params['recipe'].delete('ck_time(4i)')
    params['recipe'].delete('ck_time(5i)')
  end
end
