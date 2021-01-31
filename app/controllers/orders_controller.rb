class OrdersController < ApplicationController
  before_action :isManagement, only: [:delivered]

  def index
    if current_user_role == "admin" || current_user_role == "clerk"
      @pending_orders = Order.pendingOrders
      @delivered_orders = Order.completedOrders
      @showDeliverButton = true
      render "orders/index"
    else
      @pending_orders = Order.userPendingOrders(current_user.id)
      @delivered_orders = Order.userCompletedOrders(current_user.id)
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
    order[:order_customer_name] = params[:order_customer_name]
    order[:order_customer_email] = params[:order_customer_email]
    total = 0
    CurrentOrder.all.where(order_id: id).each { |item|
      total = total + item[:menu_item_quantity] * item[:menu_item_price]

      if item[:menu_item_quantity] > 0
        OrderItem.create!(
          order_id: id,
          menu_item_id: item[:menu_item_id],
          menu_item_name: item[:menu_item_name],
          menu_item_price: item[:menu_item_price],
          menu_item_quantity: item[:menu_item_quantity],
          imgPath: item[:items_imgPath],
        )
      end
      item.destroy
    }
    order[:order_total] = total
    order.save!
    redirect_to orders_path
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
