class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      if current_user_role == "admin"
        render "users/admin_index"
      else
        render "users/user_index"
      end
    else
      render "index"
    end
  end
end
