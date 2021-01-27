class AddImgPathToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :imgPath, :bytea
  end
end
