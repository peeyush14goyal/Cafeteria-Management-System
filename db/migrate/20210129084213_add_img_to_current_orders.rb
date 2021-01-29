class AddImgToCurrentOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :current_orders, :items_imgPath, :bytea
  end
end
