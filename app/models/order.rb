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

  def self.create_order(params, current_user, customer_type)
    cart_order = Cart.find_by(user_id: current_user.id)
    total = 0
    CartItem.all.where(order_id: cart_order.id).each { |item|
      total = total + item[:menu_item_quantity] * item[:menu_item_price]
    }
    Order.create!(
      user_id: current_user.id,
      placed_at: Date.today(),
      status: "pending",
      order_customer_name: params[:order_customer_name],
      order_customer_email: params[:order_customer_email],
      order_customer_type: customer_type,
      order_total: total,
    )
    Order.last.id
  end

  def self.mark_as_delivered(id)
    order = Order.find_by(id: id)
    if order
      order[:status] = "delivered"
      order[:delivered_at] = Date.today()
      order.save!
    end
  end

  def self.get_orders(start_date, end_date)
    all.where("placed_at >= ? AND placed_at <= ?", start_date, end_date)
  end

  def self.date_of_max_orders(specific_orders)
    dates = specific_orders.distinct.pluck(:placed_at)
    max_count = 0
    date = nil
    dates.each { |d|
      count = specific_orders.all.where(placed_at: d).count

      if count > max_count
        max_count = count
        date = d
      end
    }
    return date
  end

  def self.date_of_min_orders(specific_orders)
    dates = specific_orders.distinct.pluck(:placed_at)
    min_count = specific_orders.all.count
    date = nil
    dates.each { |d|
      count = specific_orders.where(placed_at: d).count

      if count < min_count
        min_count = count
        date = d
      end
    }
    return date
  end

  def self.max_orders_user(specific_orders)
    ids = specific_orders.distinct.pluck(:user_id)
    max_count = 0
    max_order_user_id = nil
    ids.each { |id|
      count = specific_orders.where(user_id: id).count

      if count > max_count
        max_count = count
        max_order_user_id = id
      end
    }
    user = User.find_by(id: max_order_user_id)
    return user
  end

  def self.min_orders_user(specific_orders)
    ids = specific_orders.distinct.pluck(:user_id)
    min_count = specific_orders.all.count
    min_order_user_id = nil
    ids.each { |id|
      count = specific_orders.where(user_id: id).count

      if count < min_count
        min_count = count
        min_order_user_id = id
      end
    }
    user = User.find_by(id: min_order_user_id)
    return user
  end

  def self.max_order_mode(specific_orders)
    order_type = specific_orders.distinct.pluck(:order_customer_type)
    max_count = 0
    order_mode = nil
    order_type.each { |type|
      count = specific_orders.where(order_customer_type: type).count
      puts "Count is "
      puts count

      if count > max_count
        max_count = count
        order_mode = type
      end
    }

    return order_mode
  end

  def self.report_pending_orders(specific_orders)
    specific_orders.all.where(status: "pending")
  end

  def self.report_delivered_orders(specific_orders)
    specific_orders.all.where(status: "delivered")
  end

  def self.revenue(orders)
    amount = 0
    orders.each { |order|
      amount += order[:order_total]
    }
    return amount
  end
end
