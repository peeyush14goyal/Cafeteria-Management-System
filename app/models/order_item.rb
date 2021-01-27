class OrderItem < ApplicationRecord
  validates :order_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true
  validates :menu_item_price, presence: true
  validates :menu_item_quantity, presence: true
  belongs_to :order
  def self.getOrderItems(id)
    all.where(order_id: id)
  end
end
