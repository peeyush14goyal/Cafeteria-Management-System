Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :menu_items
  resources :orders
  resources :order_items
  resources :menus
end
