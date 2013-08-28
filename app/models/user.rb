class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.find_for_facebook_oauth(auth)
    User.where(:provider => auth.provider, :uid => auth.uid).first
  end

  def self.create_from_facebook_oauth(auth)
    User.create(:name => auth.extra.raw_info.name,
                :provider => auth.provider,
                :uid => auth.uid,
                :email => auth.info.email,
                :image => auth.info.image,
                :password => Devise.friendly_token[0, 20])
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
