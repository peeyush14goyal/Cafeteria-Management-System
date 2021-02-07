class CurrentOrder < ApplicationRecord
  def self.current_user_cart(id)
    all.where(order_id: id)
  end

  def self.get_order(id)
    find_by(id: id)
  end

  def self.create_cart_order(params, current_user, current_user_role)
    id = params[:id]
    item = MenuItem.get_item(id)
    cart_order = Order.check_cart_order(current_user.id)
    customer_type = User.get_customer_type(current_user_role)
    if cart_order == nil
      order_id = Order.create_order(current_user, customer_type)
    else
      order_id = cart_order.id
    end
    existing_item = CurrentOrder.find_by(menu_item_id: item.id)
    if existing_item == nil && params[:quantity].to_i > 0
      CurrentOrder.create!(
        order_id: order_id,
        menu_item_id: id,
        menu_item_name: item[:name],
        menu_item_price: item[:price],
        items_imgPath: item[:imgPath],
        menu_item_quantity: params[:quantity].to_i,
        total: item[:price] * params[:quantity].to_i,
      )
    elsif existing_item && params[:quantity].to_i > 0
      existing_item[:menu_item_quantity] += params[:quantity].to_i
      existing_item.save!
    end
  end
end
