require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'shahadat@example.com', password: '12345678') }

  describe 'validations' do
    it 'requires a inventory name' do
      inventory = Inventory.create(name: '', user_id: user.id)

      expect(inventory).to_not be_valid
    end

    it 'requires a user' do
      inventory = Inventory.create(name: 'Inventory 1')

      expect(inventory).to_not be_valid
    end

    it 'is valid with all required attributes' do
      inventory = Inventory.create(name: 'Inventory 1', user_id: user.id)

      expect(inventory).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an user' do
      inventory = Inventory.create(name: 'Inventory 1', user_id: user.id)

      expect(inventory.user).to eql(user)
    end
  end
end
