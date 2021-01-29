Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"
  get "users/cart" => "users#cart", as: :cart
  #get "orders/pending" => "orders#pending", as: :pending_orders
  post "orders/pending/:id" => "orders#delivered", as: :delivered_order
  get "menu_items/new/:id" => "menu_items#new"
  post "uploads" => "users#upload"
  put "menus/edit/:id" => "menus#editMenu", as: :edit_menu
  resources :users
  resources :menu_items
  resources :orders
  resources :order_items
  resources :menus
  resources :current_orders

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
