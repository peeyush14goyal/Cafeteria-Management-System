class Cart < ApplicationRecord
  has_many :cart_items

  def self.create_cart_order(current_user)
    Cart.create!(user_id: current_user.id)
  end

  def self.get_cart_order(current_user)
    find_by(user_id: current_user.id)
  end
end
