class Event < ActiveRecord::Base
  include Filterable
  reverse_geocoded_by :latitude, :longitude
  belongs_to :host, class_name: User
  belongs_to :movement, class_name: Movement
  belongs_to :event_type
  has_many :attendees, dependent: :destroy
  has_many :tasks, dependent: :destroy
  after_validation :assign_coordinates

  validates_presence_of :host, :address, :zip, :name,  on: :create
  validate :event_date_cannot_be_in_the_past
  validate :end_time_cannot_be_before_start_time
  validate :times_cannot_be_blank
  validates :movement_id, presence: true
  validates :event_type_id, presence: true

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

  def date
    start_time.to_date if start_time
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
    #TODO: find a more efficiennt solution.
    Event.all.each {| event| return event if event.to_param == input}
    #find_by_name input.gsub(/-/, ' ')
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

    def times_cannot_be_blank
      errors.add(:start_time, "can't be empty") if start_time.nil? || end_time.nil?
    end


    def end_time_cannot_be_before_start_time
      errors.add(:end_time, "can't be before start time") if !(start_time.nil? || end_time.nil?) && end_time < start_time
    end

    def event_date_cannot_be_in_the_past
      errors.add(:date, "can't be in the past") if !date.nil? && date < Date.today
    end
end
