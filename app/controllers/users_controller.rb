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
    @report_data = nil
    if start_date && end_date
      @report_data = User.get_report_data(start_date, end_date)
    end
    render "users/report"
  end

  def report
    render "users/report"
  end

  def charts
    render "users/charts-section"
  end
end
