class MenusController < ApplicationController
  def index
    render "admin/index"
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
end
