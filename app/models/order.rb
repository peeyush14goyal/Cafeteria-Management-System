class Order < ApplicationRecord
  has_many :order_items
  validates :user_id, presence: true
  def self.getCount
    all.count
  end

  def self.pending_orders
    all.where(status: "pending")
  end

  def self.completed_orders
    all.where(status: "delivered")
  end

  def self.user_pending_orders(id)
    all.where("status = ? and user_id = ?", "pending", id)
  end

  def self.user_completed_orders(id)
    all.where("status = ? and user_id = ?", "delivered", id)
  end

  def self.check_cart_order(id)
    all.find_by(user_id: id, status: "cart")
  end

  def self.create_order(current_user, customer_type)
    create!(
      user_id: current_user.id,
      placed_at: DateTime.now(),
      status: "cart",
      order_customer_type: customer_type,
    )
    Order.last.id
  end

  def self.update_order_items(params)
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
  end

  def self.mark_as_delivered(id)
    order = Order.find_by(id: id)
    if order
      order[:status] = "delivered"
      order[:delivered_at] = DateTime.now()
      order.save!
    else
      flash[:error] = "Order ##{id} NOT FOUND"
    end
  end
end
