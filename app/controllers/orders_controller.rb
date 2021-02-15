class OrdersController < ApplicationController
  before_action :isManagement, only: [:delivered]

  def index
    if current_user_role == "admin" || current_user_role == "clerk"
      @pending_orders = Order.pending_orders
      @delivered_orders = Order.completed_orders
      @showDeliverButton = true
      render "orders/index"
    else
      @pending_orders = Order.user_pending_orders(current_user.id)
      @delivered_orders = Order.user_completed_orders(current_user.id)
      @role = current_user_role
      render "orders/index"
    end
  end

  def new
    @order = Cart.get_cart_order(current_user)
    if @order
      @order_items = CartItem.get_cart_items(@order.id)
    end
    @total = 0
    menus = Menu.get_active_menu
    @active_menus = []
    menus.each { |menu|
      @active_menus.push([menu[:name], menu[:id]])
    }
    if params[:active_menu_id]
      session[:menu_id] = params[:active_menu_id]
      @id = params[:active_menu_id]
    elsif session[:menu_id]
      @id = session[:menu_id]
    else
      @id = Menu.isActive.id
    end
    @items = MenuItem.get_menu_items(@id)
    render "orders/new"
  end

  def create
    redirect_to "orders/new"
  end

  def delivered
    Order.mark_as_delivered(params[:id])
    redirect_to orders_path
  end
end
