class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable 

  validates :name, presence: true

  has_many :ownerships
  has_many :movements, through: :ownerships
  alias_attribute :host_name, :name
  alias_attribute :host_email, :email
    
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

  def add_movement(movement)
    self.movements << movement
  end 
  
  def host_for_nonapproved_events? 
    nonapproved_events.any?
  end

  def nonapproved_events
    Event.where(host_id: self.id, approved: false)
  end

  def events
    Event.where(host_id: self.id)
  end
end
