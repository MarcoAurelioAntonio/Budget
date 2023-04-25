require 'rails_helper'

RSpec.describe 'group_expenses/index', type: :view do
  before(:each) do
    assign(:group_expenses, [
             GroupExpense.create!(
               group_id: 2,
               expense_id: 3
             ),
             GroupExpense.create!(
               group_id: 2,
               expense_id: 3
             )
           ])
  end

  it 'renders a list of group_expenses' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
