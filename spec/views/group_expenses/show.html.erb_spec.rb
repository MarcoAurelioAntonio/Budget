require 'rails_helper'

RSpec.describe 'group_expenses/show', type: :view do
  before(:each) do
    assign(:group_expense, GroupExpense.create!(
                             group_id: 2,
                             expense_id: 3
                           ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
