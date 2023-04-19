Rails.application.routes.draw do
  resources :foods
  devise_for :users

  root "users#index"
  resources :users
  resources :foods
  resources :inventories, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
