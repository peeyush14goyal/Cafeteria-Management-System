class MenusController < ApplicationController
  before_action :isAdmin

  def index
    @menus = Menu.all
    render "menus/index"
  end

  def update
    Menu.set_active_menu(params[:id])
    redirect_to "/menus"
  end

  def new
    render "menus/new"
  end

  def create
    Menu.create_menu(params)
    redirect_to "/menus"
  end

  def show
    @menu = Menu.find_by(id: params[:id])
    @items = MenuItem.get_menu_items(@menu[:id])
    render "menus/remove-items"
  end

  def destroy
    Menu.remove_menu(params[:id])
    redirect_to menus_path
  end

  def editMenu
    Menu.edit_menu(params)
    redirect_to menus_path
  end

  def edit
    @menu = Menu.get_menu(params[:id])
    if @menu
      render "menus/edit"
    else
      flash[:error] = "Menu does not exist"
      render menus_path
    end
  end

  def deactive
    id = params[:id]
    menu = Menu.get_menu(id)
    if menu
      menu[:active] = false
      menu.save!
    else
      flash[:error] = "Menu Not Found"
    end

    redirect_to menus_path
  end
end
