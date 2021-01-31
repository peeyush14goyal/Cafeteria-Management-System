class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      if current_user_role == "admin"
        render "users/admin_index"
      elsif current_user_role == "clerk"
        render "users/clerk"
      else
        render "users/customer_index"
      end
    else
      render "index"
    end
  end
end
