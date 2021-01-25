class Order < ApplicationRecord
  has_many :order_items
  def self.getCount
    all.count
  end

  def self.pendingOrders
    all.where(status: "pending")
  end

  def self.completedOrders
    all.where(status: "delivered")
  end

  def self.userPendingOrders(id)
    all.where("status = ? and user_id = ?", "pending", id)
  end

  def self.userCompletedOrders(id)
    all.where("status = ? and user_id = ?", "delivered", id)
  end

  def self.checkCartOrder(id)
    all.find_by(user_id: id, status: "cart")
  end
end
