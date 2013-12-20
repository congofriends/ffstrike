class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    oauth = request.env['omniauth.auth']
    oauth.extra = nil #save space in the cookie
          
    user = User.find_for_facebook_oauth(oauth)
    user = User.create_from_facebook_oauth(oauth) unless user
                
    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = oauth
      redirect_to new_user_registration_url
    end
  end
end
