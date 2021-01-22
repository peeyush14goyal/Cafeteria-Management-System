class Order < ApplicationRecord
  def self.getCount
    all.count
  end
end
