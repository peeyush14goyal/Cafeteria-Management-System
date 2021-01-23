class OrdersController < ApplicationController
  def index
    render plain: "This is Order"
  end

  def create
    puts "Params  are "
    puts params
    if current_order.length > 0
      current_order.each { |item|
        OrderItem.create!(
          order_id: item[:order_id],
          menu_item_id: item[:menu_item_id],
          menu_item_name: item[:menu_item_name],
          menu_item_price: item[:menu_item_price],
        )
      }
      current_order.clear()
      Order.create!(
        user_id: 1,
        placed_at: DateTime.now(),
      )
    end
    redirect_to "/users"
  end
end
