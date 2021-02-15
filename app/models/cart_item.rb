class CartItem < ApplicationRecord
  def self.get_cart_items(id)
    all.where(order_id: id)
  end

  def self.add_cart_item(params, current_user)
    id = params[:id]
    item = MenuItem.get_item(id)
    cart_order = Cart.get_cart_order(current_user)
    if cart_order == nil
      order_id = Cart.create_cart_order(current_user)
    else
      order_id = cart_order.id
    end
    existing_item = CartItem.get_cart_items(order_id).find_by(menu_item_id: item.id)
    if existing_item == nil && params[:quantity].to_i > 0
      CartItem.create!(
        order_id: order_id,
        menu_item_id: id,
        menu_item_name: item[:name],
        menu_item_price: item[:price],
        imgPath: item[:imgPath],
        menu_item_quantity: params[:quantity].to_i,
      )
    elsif existing_item && params[:quantity].to_i > 0
      existing_item[:menu_item_quantity] += params[:quantity].to_i
      existing_item.save!
    end
  end

  def self.get_cart_item(id, current_user)
    cart_order = Cart.find_by(user_id: current_user.id)
    item = CartItem.all.where(order_id: cart_order.id).find_by(id: id)
    item
  end

  def self.cart_to_order(order_id, cart_id)
    CartItem.all.where(order_id: cart_id).each { |item|
      if item[:menu_item_quantity] > 0
        OrderItem.create!(
          order_id: order_id,
          menu_item_id: item[:menu_item_id],
          menu_item_name: item[:menu_item_name],
          menu_item_price: item[:menu_item_price],
          menu_item_quantity: item[:menu_item_quantity],
          imgPath: item[:imgPath],
        )
      end
      item.destroy
    }
  end
end
