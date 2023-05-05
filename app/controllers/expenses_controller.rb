class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[edit update destroy]
  before_action :set_group, only: %i[index new edit create update destroy]
  before_action :set_user, only: %i[index edit create update destroy]

  # GET /expenses or /expenses.json
  def index
    @expenses = @group.expenses.order(created_at: :desc)
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @expenses = @group.expenses.order(created_at: :desc)
  end

  # GET /expenses/1/edit
  # def edit; end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(author: @author, **expense_params)

    respond_to do |format|
      if @expense.save
        format.html do
          @group_expense = GroupExpense.create(group: @group, expense: @expense)
          redirect_to group_expenses_url(@group), notice: 'Expense was successfully created.'
        end
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    if @expense.update(expense_params)
      redirect_to group_expenses_url, notice: 'Expense was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to group_expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @author = current_user
  end

  def set_group
    @group = set_user.groups.find(params[:group_id])
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:author_id, :name, :amount)
  end
end
