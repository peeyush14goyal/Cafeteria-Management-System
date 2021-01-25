class CurrentOrder < ApplicationRecord
  def self.currentUserCart(id)
    all.where(order_id: id)
  end

  def self.getOrder(id)
    find_by(id: id)
  end
end
