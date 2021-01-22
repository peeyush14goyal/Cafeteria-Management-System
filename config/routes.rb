Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :menu_items
  resources :orders
  resources :order_items
  resources :menus

  post "add_order_item/:id", to: "order_items#add_item_in_order"
end
