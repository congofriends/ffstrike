class Event < ActiveRecord::Base
  validates_presence_of :coordinator, :address, on: :create
  reverse_geocoded_by :latitude, :longitude
  belongs_to :coordinator, class_name: User
  belongs_to :host, class_name: User
  belongs_to :movement, class_name: Movement
  has_many :attendees, dependent: :destroy
  has_many :tasks, dependent: :destroy
  after_validation :assign_coordinates

  delegate :movement_name, :image,     :to => :movement
  delegate :tagline,                   :to => :movement
  delegate :coordinator_name,          :to => :coordinator
  delegate :coordinator_email,         :to => :coordinator

  def self.near_zip(zipcode, distance)
    return [] if zipcode.nil?
    zipcode = zipcode.strip
    lookup = Zipcode.find_by_zip(zipcode)
    return [] if lookup.nil? || distance.nil?
    Event.near([lookup.latitude, lookup.longitude], distance).joins(:movement).where(approved: true, movements: {published: true})
  end

  def number_of_attendees
    attendees.count
  end

  def location
    [address, city, zip].join(", ")
  end

  def threshold_size?
    [10, 50].include? self.number_of_attendees 
  end

  private
    def assign_coordinates
      lookup = Zipcode.find_by_zip(self.zip)
      self.update_attribute(:latitude, lookup.latitude) unless lookup.nil?
      self.update_attribute(:longitude, lookup.longitude) unless lookup.nil?
    end
end
