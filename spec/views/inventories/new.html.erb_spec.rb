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
end
