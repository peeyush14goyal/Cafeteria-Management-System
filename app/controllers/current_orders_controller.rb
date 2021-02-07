class CurrentOrdersController < ApplicationController
  def update
    CurrentOrder.create_cart_order(params, current_user, current_user_role)
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
