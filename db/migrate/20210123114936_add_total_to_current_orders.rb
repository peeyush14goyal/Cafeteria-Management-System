class AddTotalToCurrentOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :current_orders, :total, :decimal
  end
end
