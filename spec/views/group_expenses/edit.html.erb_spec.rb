require 'rails_helper'

RSpec.describe 'group_expenses/edit', type: :view do
  let(:group_expense) do
    GroupExpense.create!(
      group_id: 1,
      expense_id: 1
    )
  end

  before(:each) do
    assign(:group_expense, group_expense)
  end

  it 'renders the edit group_expense form' do
    render

    assert_select 'form[action=?][method=?]', group_expense_path(group_expense), 'post' do
      assert_select 'input[name=?]', 'group_expense[group_id]'

      assert_select 'input[name=?]', 'group_expense[expense_id]'
    end
  end
end
