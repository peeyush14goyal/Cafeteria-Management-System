class CurrentOrdersController < ApplicationController
  def update
    id = params[:id]
    item = MenuItem.getItem(id)
    cartOrder = Order.checkCartOrder(current_user.id)

    if cartOrder == nil
      Order.create!(
        user_id: current_user.id,
        placed_at: DateTime.now(),
        status: "cart",
      )
      order_id = Order.last.id
    else
      order_id = cartOrder.id
    end

    if item != nil && params[:quantity].to_i > 0
      CurrentOrder.create!(
        order_id: order_id,
        menu_item_id: id,
        menu_item_name: item[:name],
        menu_item_price: item[:price],
        menu_item_quantity: params[:quantity].to_i,
        total: item[:price] * params[:quantity].to_i,
      )
    end
    render "orders/new"
  end

  def destroy
    id = params[:id]
    item = CurrentOrder.getOrder(id)
    if item != nil
      item.destroy!
    end
    redirect_to cart_path
  end
end
