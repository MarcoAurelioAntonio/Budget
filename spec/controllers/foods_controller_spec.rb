require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { User.create(name: 'Admin', email: 'admin@admin.com', password: '123456') }
  let(:food) { Food.create(name: 'Food 1', measurement_unit: 'kg', price: 76) }

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

      it 'assigns foods to @foods' do
        get :index

        expect(assigns(:foods)).to eq [food]
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
      end

      it 'returns http redirect' do
        get :index

        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET #show' do
    context 'when user is logged in and is the owner of the Food' do
      before do
        user.confirm
        sign_in user
        get :show, params: { id: food.id }
      end

      it 'assigns the food to @food' do
        expect(assigns(:food)).to eq food
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
        get :show, params: { id: food.id }
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'displays a flash message asking to log in' do
        expect(flash[:alert]).to match(/need to sign in/)
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

      it 'assigns a new Food' do
        get :new

        expect(assigns(:food)).to be_a_new(Food)
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
      let(:valid_params) { { food: { name: 'Test Food', measurement_unit: 'kg', price: 76 } } }

      before do
        user.confirm
        sign_in user
      end

      it 'creates a new Food' do
        expect do
          post :create, params: valid_params
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the Food page' do
        post :create, params: valid_params

        expect(response).to redirect_to(foods_path)
      end

      it 'sets a flash notice' do
        post :create, params: valid_params

        expect(flash[:notice]).to eq('Food was successfully created.')
      end
    end

    context 'when food invalid params' do
      let(:invalid_params) { { food: { name: '' } } }

      before do
        user.confirm
        sign_in user
      end

      it 'does not create a new Food' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Food, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        post :create, params: { Food: { name: 'Test Food' } }

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:redirect)
      end

      it 'does not create a new Food' do
        expect do
          post :create, params: { Food: { name: 'Test Food' } }
        end.not_to change(Food, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
    let(:food) { Food.create(name: 'Food 1', measurement_unit: 'kg', price: 100) }
    let(:other_user) { User.create(name: 'Sohidul Islam', email: 'sohidul@example.com', password: '12345678') }
    let(:other_food) { Food.create(name: 'Food 2', measurement_unit: 'kg', price: 80) }

    context 'when user is logged in and owns the Food' do
      before do
        user.confirm
        sign_in user
      end

      it 'deletes the Food' do
        food2 = Food.create(name: 'Food 2', measurement_unit: 'kg', price: 90)

        expect do
          delete :destroy, params: { id: food2.id }
        end.to change(Food, :count).by(-1)
      end

      it 'redirects to the foods index page' do
        delete :destroy, params: { id: food.id }

        expect(response).to redirect_to(foods_path)
      end

      it 'displays a success message' do
        delete :destroy, params: { id: food.id }

        expect(flash[:notice]).to eq('Food was successfully deleted.')
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        delete :destroy, params: { id: food.id }

        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http redirect' do
        delete :destroy, params: { id: food.id }

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
