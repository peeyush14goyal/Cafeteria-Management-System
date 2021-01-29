class MenusController < ApplicationController
  def index
    @menus = Menu.all
    render "menus/index"
  end

  def update
    id = params[:id]
    old_active_menu = Menu.getActiveMenu
    if old_active_menu && old_active_menu.id != id
      old_active_menu.active = false
      old_active_menu.save!
    end
    new_active_menu = Menu.getMenu(id)
    new_active_menu.active = true
    new_active_menu.save!
    redirect_to "/menus"
  end

  def new
    render "menus/new"
  end

  def create
    Menu.create!(
      name: params[:name],
      active: false,
    )
    redirect_to "/menus"
  end

  def show
    @menu = Menu.find_by(id: params[:id])
    @items = MenuItem.activeMenuItems(@menu[:id])
    render "menus/remove-items"
  end

  def destroy
    id = params[:id]
    menu = Menu.getMenu(id)
    if menu != nil
      items = MenuItem.getMenuItems(id)
      if items
        items.destroy_all
      end
    end
    menu.destroy!
    redirect_to menus_path
  end
end
