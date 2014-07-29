class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :name, presence: true

  has_many :attendances
# verify this works
  # has_many :assignments, foreign_key: "attendee_id"
  has_many :ownerships, dependent: :destroy
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

  def full_name
    "#{name} #{surname}".titleize
  end

  def add_movement(movement)
    self.movements << movement
  end

  def host_for_nonapproved_events?
    nonapproved_events.any?
  end

  def host?
    nonapproved_events.any? || approved_events.any?
  end

  def coordinator?
    Ownership.all.map(&:user_id).include?(id)
  end

  def attendee?
    Attendance.all.map(&:user_id).include?(id)
  end

  def parent_movements
    self.movements.where(parent_id: nil)
  end

  def notes_for(event_id)
    attendances.find_by(event_id: event_id).notes
  end

  def volunteer_for(event)
    attendances.find_by(event: event).point_person if attendances.find_by(event: event)
  end

  def attendance_for(event)
    attendances.find_by(event: event)
  end

  def tasks_for(event)
     attendances.find_by(event: event).assignments.map(&:task)
  end

  def nonapproved_events
    Event.where(host_id: self.id, approved: false)
  end

  def approved_events
    Event.where(host_id: self.id, approved: true)
  end

  def events_owned
    (approved_events.concat(nonapproved_events).concat(events)).flatten.compact.uniq
  end

  def date_signed_up_for(task)
    task.assignment_for(self).updated_at.to_date
  end

  def events_attending
    Event.find(self.attendances.map(&:event_id))
  end

  def events
    movements.map(&:events).flatten.uniq
  end

  def super_admin?
    Movement.find_by_name("Congo Week").ownerships.map(&:user_id).include?(self.id)
  end


  def movements_and_groups
    movement_array = []
    movement_array << movements
    (movement_array << movements.map(&:sub_movements)).flatten.uniq
  end
end
