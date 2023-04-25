Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  # This was creted by the command: rails g scaffold...

  # resources :expenses
  # resources :group_expenses
  # resources :groups

  # This is the same as the below code, but with a personalized path:

  #resources :groups, only: [:index, :new, :create, :edit, :update, :destroy], :path => "categories" do 
  #  resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy], :path => "transactions"
  #end

  resources :users

  resources :categories, only: %i[index new create edit update destroy] do
    resources :expenses, only: %i[index new create edit update destroy]
  end

end
