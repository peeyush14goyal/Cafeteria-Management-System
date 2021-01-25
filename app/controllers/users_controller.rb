class UsersController < ApplicationController
  def index
    render "users/user_index"
  end

  def new
    render "orders/new"
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      email: params[:email],
      password: params[:password],
      role: "Customer",
    )
    existing = User.find_by(email: user.email)
    if existing != nil
      flash[:error] = "Email already exists"
      render "users/new"
    else
      if user.save
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
    @order = Order.checkCartOrder(@current_user_id)
    if @order
      @order_items = CurrentOrder.currentUserCart(@order.id)
      total = 0
      @order_items.each { |item|
        if MenuItem.find_by(id: item[:menu_item_id]) == nil && item[:menu_item_quantity] != 0
          item[:menu_item_name] = item[:menu_item_name] + " ( NOT AVAILABLE)"
          item[:menu_item_quantity] = 0
          item.save!
        else
          total += item[:menu_item_price] * item[:menu_item_quantity]
        end
      }
      @order_items = CurrentOrder.currentUserCart(@order.id)
    end
    render cart_path
  end
end
