class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #def after_sign_in_path(resource)
  #  movement_path(current_user.movement_id)
  #end
end
