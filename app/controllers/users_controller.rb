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
    @order_items = CurrentOrder.currentUserCart(@order.id)
    render cart_path
  end
end
