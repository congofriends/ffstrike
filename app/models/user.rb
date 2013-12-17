class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable 

  def self.find_for_facebook_oauth(auth)
    User.find_by(:provider => auth.provider, :uid => auth.uid)
  end

  def self.create_from_facebook_oauth(auth)
    User.create(:name => auth.info.name, 
                :provider => auth.provider,
                :uid => auth.uid,
                :email => auth.info.email,
                :password => Devise.friendly_token[0, 20])
  end

  def self.new_with_session(params, session)
    super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["info"]
      user.email = data["email"] if user.email.blank?
    end
    end
  end

end
