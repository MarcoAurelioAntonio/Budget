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
end
