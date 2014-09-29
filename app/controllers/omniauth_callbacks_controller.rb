class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
   oauth.extra = nil #save space in the cookie

    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = oauth
      redirect_to new_user_session_path, :notice => "This email is already associated with an account."
    end
  end

  def twitter
    if user.persisted?
      if @user.sign_in_count == 0
        redirect_to finish_signup_path(user), :event => :authentication #this will throw if user is not activated
        @user.update_attribute(:sign_in_count, 1)
      else
        sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
        set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
      end
    else
      session["devise.twitter_data"] = oauth
      redirect_to new_user_registration_url
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