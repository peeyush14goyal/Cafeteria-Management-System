class AddOrderIdToCurrentOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :current_orders, :order_id, :bigint
  end
end
