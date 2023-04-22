require 'rails_helper'

RSpec.describe 'invenroty_foods/new.html.erb', type: :feature do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
  let!(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
  let!(:food) { Food.create(name: 'Fettuccine Alfredo', quantity: '23', price: 10.0) }
  let!(:food2) { Food.create(name: 'Fettuccine Alfredo2', quantity: '23', price: 10.0) }

  context 'when user is not logged in' do
    before do
      user.confirm
      visit new_inventory_inventory_food_path(inventory.id)
    end

    it 'redirects to the login page' do
      expect(page).to have_content('Log in')
    end

    it 'successfull logged in redirect to new inventory page' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      expect(page).to have_content("Add Food to #{inventory.name}")
    end
  end

  context 'when user is logged in shows' do
    before do
      user.confirm
      sign_in user
      visit new_inventory_inventory_food_path(inventory.id)
    end

    it 'the inventories page title' do
      expect(page).to have_content("Add Food to #{inventory.name}")
    end

    it 'the button for Back to Inventories' do
      expect(page).to have_content('Back to Inventory')
    end
  end

  context 'when user is logged in and link click' do
    before do
      user.confirm
      sign_in user
      visit new_inventory_inventory_food_path(inventory.id)
    end

    it 'redirects me to a specif inventory' do
      click_link('Back to Inventory', href: inventory_path(inventory.id))

      expect(page).to have_current_path(inventory_path(inventory.id))
    end

    it 'redirects me to a add another inventory' do
      select 'Fettuccine Alfredo', from: 'inventory_food[food_id]'
      fill_in 'inventory_food[quantity]', with: '10'
      click_button 'Add Food'

      expect(page).to have_text('Food added successfully')
      expect(page).to have_text('Fettuccine Alfredo')
      expect(page).to have_text('10')
    end
  end
end
