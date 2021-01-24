class OrderItem < ApplicationRecord
  belongs_to :order
  def self.getOrderItems(id)
    all.where(order_id: id)
  end
end
