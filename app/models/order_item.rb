class OrderItem < ApplicationRecord
  validates :menu_item_name, presence: true
  validates :menu_item_price, presence: true
  validates :menu_item_quantity, presence: true
  belongs_to :order
  def self.get_specific_order_items(id)
    all.where(order_id: id)
  end

  def self.get_order_items(start_date, end_date)
    all.where("created_at >= ? AND created_at <= ?", start_date, end_date)
  end

  def self.max_item_ordered(start_date, end_date)
    items = OrderItem.get_order_items(start_date, end_date)
    distinct = items.distinct.pluck(:menu_item_id)
    max_count = 0
    max_ordered_item = nil
    max_item_id = nil
    distinct.each { |id|
      count = items.all.where(menu_item_id: id).count

      if count > max_count
        max_count = count
        max_item_id = id
      end
    }
    max_ordered_item = OrderItem.find_by(menu_item_id: max_item_id)
    return max_ordered_item
  end

  def self.max_item_quantity(start_date, end_date, item)
    if item
      quantity = 0
      items = OrderItem.get_order_items(start_date, end_date)
      order_items = items.all.where(menu_item_id: item[:menu_item_id])
      order_items.each { |max_item|
        quantity += max_item[:menu_item_quantity]
      }
      return quantity
    else
      return nil
    end
  end
end
