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

  def update
    if params[:order_customer_name].length == 0
      flash[:error] = "Customer Name field cannot be empty"
      redirect_to cart_path
    elsif params[:order_customer_email].length == 0
      flash[:error] = "Customer Email field cannot be empty"
      redirect_to cart_path
    else
      role = User.get_customer_type(current_user_role)
      order_id = Order.create_order(params, current_user, role)
      CartItem.cart_to_order(order_id, params[:id])
      Cart.get_cart_order(current_user).destroy
      redirect_to orders_path
    end
  end
end
