class MenuItemsController < ApplicationController
  def index
    if current_user_role == "admin"
      @items = MenuItem.getAll
      render "menu_items/index"
    end
  end

  def create
    MenuItem.create!(
      menu_id: params[:menu_id],
      name: params[:name],
      price: params[:price],
    )
    redirect_to "/menus"
  end

  def new
    @menu_id = params[:id]
    render "menu_items/new"
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.find_by(id: id)
    if menu_item
      menu_item.destroy
    end
    redirect_to menus_path
  end
end
