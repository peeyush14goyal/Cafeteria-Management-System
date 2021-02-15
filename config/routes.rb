Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"
  post "orders/pending/:id" => "orders#delivered", as: :delivered_order
  get "menu_items/new/:id" => "menu_items#new"
  post "uploads" => "users#upload"
  put "menus/edit/:id" => "menus#editMenu", as: :edit_menu
  get "users/all" => "users#all", as: :all_users
  get "users/create_user" => "users#createUser", as: :create_user
  post "users/reports" => "users#get_report", as: :get_report
  get "users/reports" => "users#report", as: :report
  get "users/stats" => "users#charts", as: :stats
  put "menus/deactive/:id" => "menus#deactive", as: :deactive_menu
  put "orders/active_items" => "orders#new", as: :active_menu_items

  resources :users
  resources :menu_items
  resources :orders
  resources :order_items
  resources :menus
  resources :carts
  resources :cart_items

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
