require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
  let!(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
  let!(:inventory2) { Inventory.create(name: 'Inventory 2', user:) }

  context 'when user is not logged in' do
    before do
      user.confirm
      visit inventories_path
    end

    it 'redirects to the login page' do
      expect(page).to have_content('Log in')
    end

    it 'successfull logged in redirect to inventories page' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
      puts page.body

      expect(page).to have_content('All Inventories')
    end
  end

  context 'when user is logged in shows' do
    before do
      user.confirm
      sign_in user
      visit inventories_path
    end

    it 'the inventories page title' do
      expect(page).to have_content('All Inventories')
    end

    it 'the name of the inventories' do
      expect(page).to have_content(inventory.name)
      expect(page).to have_content(inventory2.name)
    end

    it 'the delete button' do
      expect(page).to have_content('Delete')
    end

    it 'the show button' do
      expect(page).to have_content('Show')
    end
  end
end
