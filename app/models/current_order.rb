class CurrentOrder < ApplicationRecord
  def self.currentUserCart(id)
    all.where(order_id: id)
  end

  def self.get_order(id)
    find_by(id: id)
  end

  def self.create_cart_order(item, params, order_id)
    id = params[:id]
    item = MenuItem.get_item(id)
    cart_order = Order.check_cart_order(current_user.id)
    customer_type = User.get_customer_type(current_user_role)
    if cartOrder == nil
      order_id = Order.create_order(current_user, customer_type)
    else
      order_id = cart_order.id
    end
    if item && params[:quantity].to_i > 0
      CurrentOrder.create!(
        order_id: order_id,
        menu_item_id: id,
        menu_item_name: item[:name],
        menu_item_price: item[:price],
        items_imgPath: item[:imgPath],
        menu_item_quantity: params[:quantity].to_i,
        total: item[:price] * params[:quantity].to_i,
      )
    else
      flash[:error] = "Quantity is #{params[:quantity].to_i}"
    end
  end
end
