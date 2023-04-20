class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /users or /users.json
  def index; end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new(role: 'user')
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    puts User.any?
    puts User.count
    @user.role = 'admin' unless User.any?

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    set_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    set_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :role)
  end
end
