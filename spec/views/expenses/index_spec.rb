require 'rails_helper'

RSpec.describe 'Group expenses index', type: :feature do
  before(:each) do
    @group = Group.create(
      name: 'My Group',
      icon: 'https://examplamplamplample.com/icon.png',
      created_at: DateTime.now
    )
    @group = Group.create(
      name: 'My Group 2',
      icon: 'https://example.com/icon.png',
      created_at: DateTime.now
    )
    @group = Group.create(
      name: 'My Group 3',
      icon: 'https://exaamplamplamplamplamplamplamplamplle.com/icon.png',
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
      created_at: DateTime.now
    )

    visit group_expenses_path(1)
    puts "Group ID: #{@group_id}" # Agrega esta línea para depurar el ID del grupo
  end
end
