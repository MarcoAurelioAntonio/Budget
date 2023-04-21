require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do
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

end
