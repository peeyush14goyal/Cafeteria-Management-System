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
end
