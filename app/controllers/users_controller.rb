class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :isAdmin, only: [:all, :createUser, :get_report, :report]

  def index
    redirect_to "/"
  end

  def new
    render "users/new"
  end

  def create
    if params[:role]
      role = params[:role]
    else
      role = "Customer"
    end
    user = User.new(
      first_name: params[:first_name],
      email: params[:email],
      password: params[:password],
      role: role,
    )
    existing = User.find_by(email: user.email)
    if existing != nil
      flash[:error] = "Email already exists"
      render "users/new"
    else
      if user.save && params[:role]
        redirect_to all_users_path
      elsif user.save
        #session[:current_user_id] = user.id
        redirect_to "/signin"
      else
        flash[:error] = user.errors.full_messages.join(", ")
        render "users/new"
      end
    end
  end

  def cart
    @current_user_id = current_user.id
    @order = Order.check_cart_order(@current_user_id)
    if @order
      @order_items = CurrentOrder.current_user_cart(@order.id)
      @total = 0
      @order_items.each { |item|
        if MenuItem.find_by(id: item[:menu_item_id]) == nil && item[:menu_item_quantity] != 0
          item[:menu_item_name] = item[:menu_item_name] + " ( NOT AVAILABLE)"
          item[:menu_item_quantity] = 0
          item.save!
        else
          @total = @total + item[:menu_item_price] * item[:menu_item_quantity]
        end
      }
      @order_items = CurrentOrder.current_user_cart(@order.id)
    end
    render cart_path
  end

  def all
    @customers = User.get_customers()
    @clerks = User.get_clerks()
    render "users/all_users"
  end

  def createUser
    render "users/admin_create_user"
  end

  def get_report
    start_date = params[:start_date]
    end_date = params[:end_date]
    orders = nil
    @report_data = nil
    if start_date && end_date
      orders = Order.get_orders(start_date, end_date)
      item_max = OrderItem.max_item_ordered(start_date, end_date)
      delivered_orders = Order.report_delivered_orders(orders)
      if orders.count > 0
        @report_data = {
          max_order_date: Order.date_of_max_orders(orders),
          min_order_date: Order.date_of_min_orders(orders),
          max_order_user: Order.max_orders_user(orders),
          min_order_user: Order.min_orders_user(orders),
          mode: Order.max_order_mode(orders),
          pending_orders: Order.report_pending_orders(orders),
          delivered_orders: delivered_orders,
          start_date: start_date,
          end_date: end_date,
          max_item_ordered: item_max,
          max_item_quantity: OrderItem.max_item_quantity(start_date, end_date, item_max),
          revenue: Order.revenue(delivered_orders),
        }
      end
    end
    render "users/report"
  end

  def report
    render "users/report"
  end
end
