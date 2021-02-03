class Menu < ApplicationRecord
  validates :name, presence: true
  has_many :menu_items

  def self.isActive
    find_by(active: true)
  end
  def self.get_active_menu
    find_by(active: true)
  end

  def self.get_menu(id)
    find_by(id: id)
  end

  def self.create_menu(params)
    if params[:name]
      name = params[:name]
    else
      name = "Untitled Menu"
    end
    if params[:menu_id]
      Menu.create!(
        id: params[:menu_id],
        name: name,
        active: false,
      )
    else
      Menu.create!(
        name: name,
        active: false,
      )
    end
  end

  def self.set_active_menu(id)
    old_active_menu = Menu.get_active_menu
    if old_active_menu && old_active_menu.id != id
      old_active_menu.active = false
      old_active_menu.save!
    end
    new_active_menu = Menu.get_menu(id)
    new_active_menu.active = true
    new_active_menu.save!
  end

  def self.remove_menu(id)
    menu = Menu.getMenu(id)
    if menu != nil
      items = MenuItem.getMenuItems(id)
      if items
        items.destroy_all
      end
    end
    menu.destroy!
  end

  def self.edit_menu(params)
    id = params[:id]
    menu = Menu.getMenu(id)
    if menu
      menu[:name] = params[:menu_name]
      menu.save!
    else
      Menu.create!(
        name: params[:menu_name],
        active: false,
      )
    end
  end
end
