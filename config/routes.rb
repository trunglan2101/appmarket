Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :categories
  resources :products
  root 'static#home'
  get "search", to: "products#search"
end
