class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  helper_method :current_user

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def current_user
    #Memoization
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end

  def current_user_role
    current_user.role
  end

  def isAdmin
    if current_user_role == "Customer" || current_user_role == "clerk"
      flash[:error] = "Access Denied"
      redirect_to "/"
    end
  end

  def isManagement
    if current_user_role == "Customer"
      flash[:error] = "Access Denied"
      redirect_to "/"
    end
  end

  def img_string(picture)
    image = File.open(picture) { |img| img.read }
    img_code = Base64.encode64 image
    return img_code
  end
end
