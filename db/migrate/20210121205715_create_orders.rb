class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :placed_at
      t.bigint :user_id
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
