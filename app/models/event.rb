class Event < ActiveRecord::Base
  include Filterable
  reverse_geocoded_by :latitude, :longitude
  belongs_to :host, class_name: User
  belongs_to :movement, class_name: Movement
  belongs_to :event_type
  has_many :attendees, dependent: :destroy
  has_many :tasks, dependent: :destroy
  after_validation :assign_coordinates

  validates :host, :address, :city, :state, :zip, :name, presence: true
  validates :name, uniqueness: true

  validate :start_date_cannot_be_in_the_past
  validate :end_time_cannot_be_before_start_time 
  validates :start_time, presence: true
  validates :movement, presence: true
  validates :event_type, presence: true

  has_attached_file :image,
                    :styles => { :medium => '280x150', :thum => '50x50' },
                    :default_url => 'fotc.jpg'

  validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
  validates_attachment_size :image, :less_than => 5.megabytes

  delegate :movement_name,      :to => :movement
  delegate :tagline,            :to => :movement
  delegate :host_name,          :to => :host
  delegate :host_email,         :to => :host

  def self.near_zip(zipcode, distance)
    return [] if zipcode.nil?
    zipcode = zipcode.strip
    if Rails.env.test?
      lookup = Zipcode.find_by_zip(zipcode)
      return [] if lookup.nil? || distance.nil?
      Event.near([lookup.latitude, lookup.longitude], distance).joins(:movement).where(approved: true, movements: {published: true})
    else
      Event.near(zipcode, distance).joins(:movement).where(approved: true, movements: {published: true})
    end
  end

  def type
    event_type.name
  end

  def number_of_attendees
    attendees.count
  end

  def location
    [address, address2, city, state, zip].reject{|i| i.nil? || i.empty?}.join(", ")
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

  def start_date
    start_time.to_date if start_time
  end

  def end_date
    end_time.to_date if end_time
  end

  def formatted_time
    if end_time.nil?
     start_time.strftime("%m/%d/%Y,%l:%M %p") 
    elsif (start_date == end_date)
      build_datetime( "%m/%d/%Y,%l:%M %p to", "%l:%M %p") 
    else
      build_datetime("%m/%d/%Y,%l:%M %p to ", "%m/%d/%Y,%l:%M %p")
    end
  end

  def build_datetime(start_date, end_date)
    start_time.strftime(start_date) + end_time.strftime(end_date)
  end

  private
    def assign_coordinates
      if self.latitude.nil? || self.longitude.nil?
        if Rails.env.test?
          self.update_attribute(:latitude, 41.9215421 )
          self.update_attribute(:longitude, -87.70248169999999)
        else
          coordinates = Geocoder.coordinates(location)
          self.update_attribute(:latitude,coordinates.first) unless coordinates.nil?
          self.update_attribute(:longitude,coordinates.last) unless coordinates.nil?
        end
      end
    end

    def end_time_cannot_be_before_start_time
      errors.add(:end_time, "can't be before start time") if (end_time? && start_time) && (end_time < start_time)
    end

    def start_date_cannot_be_in_the_past
      errors.add(:start_date, "can't be in the past") if !start_date.nil? && start_date < Date.today
    end

end
