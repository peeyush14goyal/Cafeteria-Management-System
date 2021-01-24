class CreateCurrentOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :current_orders do |t|
      t.bigint :menu_item_id
      t.string :menu_item_name
      t.decimal :menu_item_price
      t.bigint :menu_item_quantity

      t.timestamps
    end
  end
end
