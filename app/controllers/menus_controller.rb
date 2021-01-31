class MenusController < ApplicationController
  before_action :isAdmin

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

  def editMenu
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
    redirect_to menus_path
  end

  def edit
    id = params[:id]
    @menu = Menu.find_by(id: id)
    if @menu
      render "menus/edit"
    else
      flash[:error] = "Menu does not exist"
      render menus_path
    end
  end
end
