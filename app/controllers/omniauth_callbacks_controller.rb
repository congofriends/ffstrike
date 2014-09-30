class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    oauth.extra = nil #save space in the cookie
    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = oauth
      redirect_to new_user_session_path, :alert => t('devise.registrations.email_taken')
    end
  end

  def twitter
    oauth.extra = nil
    if user.sign_in_count == 0
      redirect_to finish_signup_path(user), :event => :authentication #this will throw if user is not activated
      @user.update_attribute(:sign_in_count, 1)
    else
      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    end
  end

  private

  def user
    @user ||= User.from_omniauth(oauth)
  end

  def oauth
    @oauth ||= request.env['omniauth.auth']
  end

end