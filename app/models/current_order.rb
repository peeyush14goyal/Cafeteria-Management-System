class CurrentOrder < ApplicationRecord
  def self.currentUserCart(id)
    all.where(order_id: id)
  end
end
