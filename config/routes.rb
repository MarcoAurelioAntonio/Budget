Rails.application.routes.draw do
  # get 'shopping_list/index'
  devise_for :users

  root to: 'recipes#index'
  get '/public_recipes', to: 'recipes#index'
  resources :users
  resources :recipes do
    resources :recipe_foods
  end
  resources :foods
  
  get '/shopping_list', to: 'shopping_list#index'

  resources :inventories, only: [:index, :show, :new, :create, :destroy] do
    resources :inventory_foods, only: [ :new, :create, :destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
