Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :categories do
    collection {post :import}
  end
  resources :products do
    collection {post :import}
  end
  resources :carts
  resources :cart_items
  resources :order_items
  resources :orders
  root 'categories#index'
  get "search", to: "products#search"
end
