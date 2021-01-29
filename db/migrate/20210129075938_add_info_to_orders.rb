class AddInfoToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_customer_type, :string
    add_column :orders, :order_customer_name, :string
    add_column :orders, :order_customer_email, :string
    add_column :orders, :order_total, :bigint
  end
end
