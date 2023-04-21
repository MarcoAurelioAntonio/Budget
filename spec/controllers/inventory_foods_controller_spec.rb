require 'rails_helper'

RSpec.describe InventoryFoodsController, type: :controller do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
  let(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
  let(:food) { Food.create(name: 'Fettuccine Alfredo', quantity: '23', price: 10.0) }
  let(:inventory_food) { InventoryFood.create(id: 97, quantity: 5, inventory:, food:) }

  describe 'GET #new' do
    context 'when user is logged' do
      before do
        user.confirm
        sign_in user
      end

      it 'returns a success response' do
        get :new, params: { inventory_id: inventory.id }

        expect(response).to be_successful
      end

      it 'assigns a new inventory food' do
        get :new, params: { inventory_id: inventory.id }

        expect(assigns(:inventory_food)).to be_a_new(InventoryFood)
      end

      it 'assigns to current inventory' do
        get :new, params: { inventory_id: inventory.id }

        expect(assigns(:inventory_food).inventory).to eq(inventory)
      end

      it 'renders the new template' do
        get :new, params: { inventory_id: inventory.id }

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :new, params: { inventory_id: inventory.id }

        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http redirect' do
        get :new, params: { inventory_id: inventory.id }

        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
    let(:other_user) { User.create(name: 'Shahadat Hossain2', email: 'test2@example.com', password: '12345678') }
    let(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
    let(:other_inventory) { Inventory.create(name: 'Inventory 2', user: other_user) }
    let(:food) { Food.create(name: 'Fettuccine Alfredo', quantity: '23', price: 10.0) }

    context 'when user is logged in and the food already exists' do
      before do
        user.confirm
        sign_in user

        InventoryFood.create(inventory_id: inventory.id, food_id: food.id, quantity: 10)
        post :create,
             params: { inventory_id: inventory.id, inventory_food: { food_id: food.id, quantity: 5 } }
      end

      it 'updates the existing inventory_food record' do
        expect(inventory.inventory_foods.find_by(food_id: food.id).quantity).to eq(15)
      end

      it 'redirects to the inventory page' do
        expect(response).to redirect_to(inventory_path(inventory))
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
