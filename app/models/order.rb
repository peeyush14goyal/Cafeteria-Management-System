class Order < ApplicationRecord
  has_many :order_items
  def self.getCount
    all.count
  end

  def self.pendingOrders
    all.where(delivered_at: nil)
  end

  def self.completedOrders
    all.where("delivered_at > ?", 0)
  end

  def self.checkCartOrder(id)
    all.find_by(user_id: id, status: "cart")
  end
end
