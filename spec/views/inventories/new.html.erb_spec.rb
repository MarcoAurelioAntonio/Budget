require 'rails_helper'

RSpec.describe 'inventories/new.html.erb', type: :feature do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
  let!(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
  let!(:inventory2) { Inventory.create(name: 'Inventory 2', user:) }

  context 'when user is not logged in' do
    before do
      user.confirm
      visit new_inventory_path
    end

    it 'redirects to the login page' do
      expect(page).to have_content('Log in')
    end

    it 'successfull logged in redirect to new inventory page' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      expect(page).to have_content('New Inventory')
    end
  end

  context 'when user is logged in shows' do
    before do
      user.confirm
      sign_in user
      visit new_inventory_path
    end

    it 'the inventories page title' do
      expect(page).to have_content('New Inventory')
    end
    it 'the inventories page title' do
      expect(page).to have_content('New Inventory')
    end

    it 'the button for Back to Inventories' do
      expect(page).to have_content('Back to Inventories')
    end
  end

  context 'when user is logged in and link click' do
    before do
      user.confirm
      sign_in user
      visit new_inventory_path
    end

    it 'redirects me to a specif inventory' do
      click_link('Back to Inventories', href: inventories_path)

      expect(page).to have_current_path(inventories_path)
    end

    it 'redirects me to a add another inventory' do
      fill_in 'inventory_name', with: 'My New Inventory'
      click_button 'Create Inventory'
      expect(page).to have_current_path(inventories_path)
      expect(page).to have_content('Inventory was successfully created.')
      expect(page).to have_content('My New Inventory')
    end
  end
end
