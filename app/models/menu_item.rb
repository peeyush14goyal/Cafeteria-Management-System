class MenuItem < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true
  validates :price, presence: true

  def self.get_item(id)
    all.find_by(id: id)
  end

  def self.get_all_items
    all
  end

  def self.get_menu_items(id)
    all.where(menu_id: id)
  end

  def self.decodeBase64(encoded_base64_string)
    return decode(encoded_base64_string, "base64")
  end

  def self.create_item(params, img_string)
    menu = Menu.get_menu(params[:menu_id])

    if menu == nil
      Menu.create_menu(params)
      menu = Menu.get_menu(params[:menu_id])
    end
    MenuItem.create!(
      menu_id: menu.id,
      name: params[:item_name],
      price: params[:price],
      imgPath: img_string,
    )
  end

  def self.delete_item(id)
    menu_item = MenuItem.find_by(id: id)
    if menu_item
      menu_item.destroy
    end
  end

  def self.update_item(params, img_string)
    id = params[:id]
    item = MenuItem.get_item(id)
    item[:menu_id] = params[:menu_id]
    item[:name] = params[:name]
    item[:price] = params[:price]
    if img_string && img_string.length > 0
      item[:imgPath] = img_string
    end
    item.save!
  end
end
