class OrderItemsController < ApplicationController
  def index
    render plain: "This is Order Items"
  end

  def add_item_in_order
    id = params[:id]
    item = MenuItem.getItem(id)
    puts item.name

    present = current_order.index { |x| x[:menu_item_id] == id }

    if present == nil
      current_order.push({
        order_id: Order.getCount + 1,
        menu_item_id: id,
        menu_item_name: item.name,
        menu_item_price: item.price,
        menu_item_quantity: params[:quantity],
      })
    else
      current_order[present][:menu_item_quantity] = params[:quantity]
    end
    puts current_order.join("\n")
    redirect_to "/users"
  end
end
