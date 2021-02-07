class RemovePlacedFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :placed_at, :datetime
    remove_column :orders, :delivered_at, :datetime
  end
end
