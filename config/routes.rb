Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :categories
  resources :products
  resources :carts
  resources :cart_items
  resources :order_items
  resources :orders
  root 'categories#index'
  get "search", to: "products#search"
end
