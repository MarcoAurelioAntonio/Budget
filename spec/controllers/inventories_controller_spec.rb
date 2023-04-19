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

  describe 'GET #show' do
    context 'when user is logged in and is the owner of the inventory' do
      before do
        user.confirm
        sign_in user
        get :show, params: { id: inventory.id }
      end

      it 'assigns the current user to @user' do
        expect(assigns(:user)).to eq user
      end

      it 'assigns the inventory to @inventory' do
        expect(assigns(:inventory)).to eq inventory
      end

      it 'renders the show template' do
        expect(response).to render_template :show
      end

      it 'returns a success status code' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      before do
        get :show, params: { id: inventory.id }
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'displays a flash message asking to log in' do
        expect(flash[:alert]).to match(/need to sign in/)
      end
    end

    context 'when user is logged in but is not the owner of the inventory' do
      let(:other_user) { User.create(name: 'Sohidul Islam', email: 'sohidul@example.com', password: '12345678') }
      let(:other_inventory) { Inventory.create(name: 'Inventory 2', user: other_user) }

      before do
        user.confirm
        sign_in user
        get :show, params: { id: other_inventory.id }
      end

      it 'redirects to the inventory index page' do
        expect(response).to redirect_to(inventories_path)
      end

      it 'displays a flash unauthorized message' do
        expect(flash[:notice]).to eq 'You are not authorized to view this inventory.'
      end
    end

    context 'when the inventory does not exist' do
      before do
        user.confirm
        sign_in user
        get :show, params: { id: 999 }
      end

      it 'redirects to the inventory index page' do
        expect(response).to redirect_to(inventories_path)
      end

      it 'displays a flash message saying the inventory does not exist' do
        expect(flash[:notice]).to eq 'Inventory not found with id = 999'
      end
    end
  end

  describe 'GET #new' do
    context 'when user is logged' do
      before do
        user.confirm
        sign_in user
      end

      it 'returns a success response' do
        get :new
        expect(response).to be_successful
      end

      it 'assigns a new inventory' do
        get :new
        expect(assigns(:inventory)).to be_a_new(Inventory)
        expect(assigns(:inventory).user).to eq(user)
      end

      it 'assigns to current user' do
        get :new
        expect(assigns(:inventory).user).to eq(user)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :new
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(:redirect)
      end

      it 'returns http redirect' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }

    context 'when user is logged in with valid params' do
      let(:valid_params) { { inventory: { name: 'Test Inventory' } } }

      before do
        user.confirm
        sign_in user
      end

      it 'creates a new inventory' do
        expect do
          post :create, params: valid_params
        end.to change(Inventory, :count).by(1)
      end

      it 'redirects to the inventory page' do
        post :create, params: valid_params
        expect(response).to redirect_to(inventories_path(assigns(:inventory)))
      end

      it 'sets a flash notice' do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Inventory was successfully created.')
      end
    end

    context 'when user is logged in with invalid params' do
      let(:invalid_params) { { inventory: { name: '' } } }

      before do
        user.confirm
        sign_in user
      end

      it 'does not create a new inventory' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Inventory, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end
