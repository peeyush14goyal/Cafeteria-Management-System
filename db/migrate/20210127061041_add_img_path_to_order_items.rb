class AddImgPathToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :imgPath, :bytea
  end
end
