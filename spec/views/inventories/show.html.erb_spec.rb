require 'rails_helper'

RSpec.describe 'inventories/show.html.erb', type: :feature do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
  let!(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
  let(:food) { Food.create(name: 'Fettuccine Alfredo', quantity: '23', price: 10.0) }
  let(:inventory_food) { InventoryFood.create(id: 97, quantity: 5, inventory:, food:) }

  context 'when user is not logged in' do
    before do
      user.confirm
      visit inventory_path(inventory)
    end

    it 'redirects to the login page' do
      expect(page).to have_content('Log in')
    end

    it 'successfull logged in redirect to inventories page' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'

      expect(page).to have_content(inventory.name)
    end
  end

  context 'when user is logged in shows' do
    before do
      user.confirm
      sign_in user
      visit inventory_path(inventory)
    end

    it 'the inventory page title' do
      expect(page).to have_content(inventory.name)
    end

    it 'the name of the inventory food name' do
      inventory.inventory_foods.each do |inventory_food|
        expect(page).to have_content(inventory_food.food.name)
      end
    end

    it 'the name of the inventory food quantity' do
      inventory.inventory_foods.each do |inventory_food|
        expect(page).to have_content(inventory_food.quantity)
      end
    end

    it 'the button for Back to Inventories' do
      expect(page).to have_content('Back to Inventories')
    end

    it 'the button for add new food in the inventory' do
      expect(page).to have_content('Add Food')
    end

    it 'deletes an inventory food item from the inventory' do
      expect(page).to have_no_content('Delete')
    end
  end

  context 'when user is logged in and link click' do
    before do
      user.confirm
      sign_in user
      visit inventory_path(inventory)
    end

    it 'redirects me to a specif inventory' do
      click_link('Back to Inventories', href: inventories_path)

      expect(page).to have_current_path(inventories_path)
    end

    it 'redirects me to a add another inventory' do
      click_link('Add Food', href: new_inventory_inventory_food_path(inventory.id))

      expect(page).to have_current_path(new_inventory_inventory_food_path(inventory.id))
    end

    it 'redirects me to a add another inventory' do
      inventory.inventory_foods.each do |inventory_food|
        click_link('Delete', href: inventory_inventory_food_path(inventory_food.id))

        expect(page).to have_current_path(inventory.id)
        expect(page).not_to have_content(inventory.name)
      end
    end
  end
end
