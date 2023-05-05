require 'rails_helper'

RSpec.describe 'Group expenses index', type: :feature do
  before(:each) do
    @group = Group.create(
      name: 'My Group',
      icon: 'https://example.com/icon.png',
      created_at: DateTime.now
    )
    @user = User.create(
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password'
    )
    @expense = Expense.create(
      name: 'Expense 1',
      amount: 100,
      author: @user,
      group: @group,
      created_at: DateTime.now
    )
    visit group_expenses_path(@group)
  end

  it 'should have an expense name' do
    expect(page).to have_content(@expense.name)
  end
end
