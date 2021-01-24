class OrdersController < ApplicationController
  def index
    if current_user_role == "admin"
      @pending_orders = Order.all.where(status: "pending")
      @delivered_orders = Order.all.where(status: "delivered")
      @role = current_user_role
      render "orders/index"
    else
      @pending_orders = Order.all.where("status = ? and user_id = ?", "pending", current_user.id)
      @delivered_orders = Order.all.where("status = ? and user_id = ?", "delivered", current_user.id)
      @role = current_user_role
      render "orders/index"
    end
  end

  def new
    render "orders/new"
  end

  def create
    redirect_to "orders/new"
  end

  def update
    id = params[:id]
    order = Order.find_by(id: id)
    order[:status] = "pending"
    order.save!
    CurrentOrder.all.where(order_id: id).each { |item|
      OrderItem.create!(
        order_id: id,
        menu_item_id: item[:menu_item_id],
        menu_item_name: item[:menu_item_name],
        menu_item_price: item[:menu_item_price],
        menu_item_quantity: item[:menu_item_quantity],
      )
      item.destroy
    }

    render plain: "Order saved"
  end

  def show
  end

  def delivered
    id = params[:id]
    order = Order.find_by(id: id)
    order[:status] = "delivered"
    order[:delivered_at] = DateTime.now()
    order.save!
    redirect_to orders_path
  end
end
