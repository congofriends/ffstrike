class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
   oauth.extra = nil #save space in the cookie

    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = oauth
      redirect_to new_user_registration_url
    end
  end

  def twitter
   oauth.extra = nil #save space in the cookie

    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = oauth
      redirect_to new_user_registration_url
    end
  end

  private

  def user
    @user ||=
      User.find_for_oauth(oauth) ||
      User.create_from_oauth(oauth)
  end

  def oauth
    @oauth ||= request.env['omniauth.auth']
  end

end