class CartsController < ApplicationController
  def index
    @order = Cart.get_cart_order(current_user)
    if @order
      @order_items = CartItem.get_cart_items(@order.id)
      @total = 0
      @order_items.each { |item|
        if MenuItem.find_by(id: item[:menu_item_id]) == nil && item[:menu_item_quantity] != 0
          item[:menu_item_name] = item[:menu_item_name] + " ( NOT AVAILABLE)"
          item[:menu_item_quantity] = 0
          item.save!
        else
          @total += item[:menu_item_price] * item[:menu_item_quantity]
        end
      }
      @order_items = CartItem.get_cart_items(@order.id)
    end
    render "carts/index"
  end
end
