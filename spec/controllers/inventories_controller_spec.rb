require 'rails_helper'

RSpec.describe InventoriesController, type: :controller do
  let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
  let(:inventory) { Inventory.create(name: 'Inventory 1', user:) }
  describe 'GET #index' do
    context 'when user is logged in' do
      before do
        user.confirm
        sign_in user
      end

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'assigns the current user to @user' do
        get :index
        expect(assigns(:user)).to eq user
      end

      it "assigns the user's inventories to @inventories" do
        get :index
        expect(assigns(:inventories)).to eq [inventory]
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(:redirect)
      end

      it 'returns http redirect' do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
