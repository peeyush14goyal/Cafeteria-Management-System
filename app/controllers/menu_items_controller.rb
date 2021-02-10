class MenuItemsController < ApplicationController
  before_action :isAdmin

  def index
    @items = MenuItem.get_all_items
    render "menu_items/index"
  end

  def create
    if params[:picture]
      img_string = img_string(params[:picture])
    else
      img_string = nil
    end
    MenuItem.create_item(params, img_string)
    redirect_to "/menus"
  end

  def new
    @menu = Menu.get_menu(params[:id])
    @menus = []
    Menu.all.each { |menu|
      @menus.push([menu[:name], menu[:id]])
    }
    render "menu_items/new"
  end

  def destroy
    id = params[:id]
    MenuItem.delete_item(id)
    redirect_to menus_path
  end

  def edit
    id = params[:id]
    @item = MenuItem.get_item(id)
    render "menu_items/edit"
  end

  def update
    if params[:picture]
      img_string = img_string(params[:picture])
    else
      img_string = nil
    end
    MenuItem.update_item(params, img_string)
    redirect_to menu_items_path
  end
end
