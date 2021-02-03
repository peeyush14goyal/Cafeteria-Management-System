class CurrentOrdersController < ApplicationController
  def update
    CurrentOrder.create_cart_order(item, params, order_id)
    render "orders/new"
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
