class CurrentOrdersController < ApplicationController
  def update
    CartItem.add_cart_item(params, current_user)
    redirect_to new_order_path
  end

  def destroy
    id = params[:id]
    item = CurrentOrder.get_order(id)
    if item != nil
      item.destroy!
    end
    redirect_to cart_path
  end
end
