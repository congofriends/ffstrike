class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
  after_filter :discard_flash_if_xhr
  before_filter :set_locale
  before_filter :set_locale_hash

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != new_user_session_path &&
        request.fullpath != new_user_registration_path &&
        request.fullpath != new_user_password_path &&
        request.fullpath != destroy_user_session_path &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_update_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_in_path_for(resource)
    return root_path if session[:previous_url] && session[:previous_url].include?("/users")
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :surname
    devise_parameter_sanitizer.for(:invite).concat [:movement]
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :surname
    devise_parameter_sanitizer.for(:account_update) << :phone
    devise_parameter_sanitizer.for(:account_update) << :textable
  end

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def set_locale
    params[:locale] = 'en' unless params[:locale]
    I18n.locale = params[:locale] || I18n.default_locale
    gon.locale = I18n.locale
  
  end

  def set_locale_hash
    @locale_hash = {"en" => "English", "fr"  => "Français", "es" => "Español", "it" => "Italiano"}
  end

end
