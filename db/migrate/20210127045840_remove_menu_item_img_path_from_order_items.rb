class RemoveMenuItemImgPathFromOrderItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_items, :menu_item_imgPath, :string
  end
end
