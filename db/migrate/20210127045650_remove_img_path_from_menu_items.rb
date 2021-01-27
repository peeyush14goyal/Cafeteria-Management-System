class RemoveImgPathFromMenuItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :menu_items, :imgPath, :string
  end
end
