require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { User.create(name: 'Admin', email: 'admin@admin.com', password: '123456') }
  let(:recipe) do
    Recipe.create(
      name: 'Carrot Soup',
      user_id: user.id,
      prep_time: 3.hours,
      cook_time: 1.hours,
      public: true
    )
  end

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

      it 'renders the index template' do
        get :index

        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    context 'when user is logged in and is the owner of the recipe' do
      before do
        user.confirm
        sign_in user
        get :show, params: { id: recipe.id }
      end

      it 'assigns the recipey to @recipe' do
        expect(assigns(:recipe)).to eq recipe
      end

      it 'renders the show template' do
        expect(response).to render_template :show
      end

      it 'returns a success status code' do
        expect(response).to have_http_status(:success)
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

      it 'assigns a new recipe' do
        get :new

        expect(assigns(:recipe)).to be_a_new(Recipe)
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
      let(:valid_params) do
        { recipe: { name: 'Recipe Inventory', 'ck_time(4i)': 2, 'ck_time(5i)': 30, 'pp_time(4i)': 1,
                    'pp_time(5i)': 20 } }
      end

      before do
        user.confirm
        sign_in user
      end

      it 'creates a new inventory' do
        expect do
          post :create, params: valid_params
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the recipes page' do
        post :create, params: valid_params

        expect(response).to redirect_to(recipes_path)
      end

      it 'sets a flash notice' do
        post :create, params: valid_params

        expect(flash[:notice]).to eq('Recipe was successfully created.')
      end
    end

    context 'when user is logged in with invalid params' do
      let(:invalid_params) do
        { recipe: { name: '', 'ck_time(4i)': 2, 'ck_time(5i)': 30, 'pp_time(4i)': 1, 'pp_time(5i)': 20 } }
      end

      before do
        user.confirm
        sign_in user
      end

      it 'does not create a new recipe' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Recipe, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        post :create, params: { recipe: { name: 'Test Recipe' } }

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:redirect)
      end

      it 'does not create a new recipe' do
        expect do
          post :create, params: { recipe: { name: 'Test Recipe' } }
        end.not_to change(Recipe, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }
    let(:recipe) { Recipe.create(name: 'Recipe 1', user:) }
    let(:other_user) { User.create(name: 'Sohidul Islam', email: 'sohidul@example.com', password: '12345678') }
    let(:other_recipe) { Recipe.create(name: 'Recipe 2', user: other_user) }

    context 'when user is logged in and owns the recipe' do
      before do
        user.confirm
        sign_in user
      end

      it 'deletes the recipe' do
        recipe2 = Recipe.create(name: 'Recipe 2', user:)

        expect do
          delete :destroy, params: { id: recipe2.id }
        end.to change(Recipe, :count).by(-1)
      end

      it 'redirects to the recipes index page' do
        delete :destroy, params: { id: recipe.id }

        expect(response).to redirect_to(recipes_path)
      end

      it 'displays a success message' do
        delete :destroy, params: { id: recipe.id }

        expect(flash[:notice]).to eq('Recipe was successfully deleted.')
      end
    end

    context 'when user is logged in and does not own the recipe' do
      before do
        user.confirm
        sign_in user
      end

      it 'does not destroy the recipe' do
        other_recipe2 = Recipe.create(name: 'Recipe 2', user: other_user)

        expect do
          delete :destroy, params: { id: other_recipe2.id }
        end.to_not change(Recipe, :count)
      end

      it 'redirects to the inventories index page' do
        delete :destroy, params: { id: other_recipe.id }

        expect(response).to redirect_to recipes_path
      end

      it 'displays a unauthorize message' do
        delete :destroy, params: { id: other_recipe.id }

        expect(flash[:notice]).to eq('You are not authorized to delete this recipe.')
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        delete :destroy, params: { id: recipe.id }

        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http redirect' do
        delete :destroy, params: { id: recipe.id }

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
