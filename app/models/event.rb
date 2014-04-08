class Event < ActiveRecord::Base
  validates_presence_of :host, :address, :zip, on: :create
  reverse_geocoded_by :latitude, :longitude
  belongs_to :host, class_name: User
  belongs_to :movement, class_name: Movement
  belongs_to :event_type
  has_many :attendees, dependent: :destroy
  has_many :tasks, dependent: :destroy
  after_validation :assign_coordinates

  delegate :movement_name, :image,     :to => :movement
  delegate :tagline,                   :to => :movement
  delegate :host_name,          :to => :host
  delegate :host_email,         :to => :host

  def self.near_zip(zipcode, distance)
    return [] if zipcode.nil?
    zipcode = zipcode.strip
    lookup = Zipcode.find_by_zip(zipcode)
    return [] if lookup.nil? || distance.nil?
    Event.near([lookup.latitude, lookup.longitude], distance).joins(:movement).where(approved: true, movements: {published: true})
  end

  def type
    event_type.name
  end

  def number_of_attendees
    attendees.count
  end

  def location
    [address, city, zip, state].join(", ")
  end

  def assign_host_and_approve user
    self.update(approved: (self.movement.users.reload.include?(user)), host: user)
  end

  def threshold_size?
    [10, 50].include? self.number_of_attendees 
  end

  def to_param
    name.gsub(/ /, '-')
  end

  def self.find_by_param input
    find_by_name input.gsub(/-/, ' ')
  end

  def host? user
    user && self.host_id == user.id
  end
                                  
  private
    def assign_coordinates
      lookup = Zipcode.find_by_zip(self.zip)
      self.update_attribute(:latitude, lookup.latitude) unless lookup.nil?
      self.update_attribute(:longitude, lookup.longitude) unless lookup.nil?
    end
end
