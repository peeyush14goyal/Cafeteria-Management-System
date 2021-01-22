class ApplicationController < ActionController::Base
  before_action :current_order

  def current_order
    return $current_order if $current_order

    $current_order = []
    return $current_order
  end
end
