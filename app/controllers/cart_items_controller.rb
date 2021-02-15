class CartItemsController < ApplicationController
  def update
    CartItem.add_cart_item(params, current_user)
    redirect_to new_order_path
  end

  def destroy
    id = params[:id]
    item = CartItem.get_cart_item(id, current_user)
    if item != nil
      item.destroy!
    end
    redirect_to carts_path
  end
end
