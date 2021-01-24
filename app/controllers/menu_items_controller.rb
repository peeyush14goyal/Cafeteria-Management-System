class MenuItemsController < ApplicationController
  def index
    if current_user_role == "admin"
      render "menus/index"
    end
  end
end
