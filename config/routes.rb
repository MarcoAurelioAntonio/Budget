Rails.application.routes.draw do
  resources :foods
  devise_for :users

  root "recipes#index"
  resources :users
  resources :recipes
  resources :foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
