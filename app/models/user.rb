class User < ApplicationRecord
  has_many :orders
  has_one :carts
  validates :first_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  has_secure_password

  def self.get_customers
    all.where(role: "Customer")
  end

  def self.get_clerks
    all.where(role: "clerk")
  end

  def self.get_customer_type(current_user_role)
    if (current_user_role == "admin" || current_user_role == "clerk")
      "Walk-in"
    else
      "Online"
    end
  end

  def self.get_report_data(start_date, end_date)
    report_data = nil
    orders = Order.get_orders(start_date, end_date)
    item_max = OrderItem.max_item_ordered(start_date, end_date)
    delivered_orders = Order.report_delivered_orders(orders)
    if orders.count > 0
      report_data = {
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
    report_data
  end
end
