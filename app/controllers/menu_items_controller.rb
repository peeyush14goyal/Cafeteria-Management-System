class MenuItemsController < ApplicationController
  def index
    if current_user_role == "admin"
      @items = MenuItem.getAll
      render "menu_items/index"
    end
  end

  def create
    if params[:picture]
      img_string = imgString(params[:picture])
    else
      img_string = nil
    end
    menu = Menu.getMenu(params[:menu_id])

    if menu == nil
      Menu.create!(
        id: params[:menu_id],
        name: "Untitled Menu",
        active: false,
      )
      menu = Menu.getMenu(params[:menu_id])
    end
    MenuItem.create!(
      menu_id: menu.id,
      name: params[:name],
      price: params[:price],
      imgPath: img_string,
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

  def edit
    id = params[:id]
    @item = MenuItem.getItem(id)
    render "menu_items/edit"
  end

  def update
    if params[:picture]
      img_string = imgString(params[:picture])
    else
      img_string = nil
    end
    id = params[:id]
    item = MenuItem.getItem(id)
    item[:menu_id] = params[:menu_id]
    item[:name] = params[:name]
    item[:price] = params[:price]
    item[:imgPath] = img_string
    item.save!
    redirect_to menu_items_path
  end
end
