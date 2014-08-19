class Event < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  belongs_to :host, class_name: User
  belongs_to :movement, class_name: Movement
  belongs_to :event_type
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :user
  has_many :tasks, dependent: :destroy

  after_create :populate_tasks, :assign_coordinates

  # validates :host, :address, :city, :state, :zip, :name, :description, presence: true
  validates :host, :name, :description, presence: true

  validate :start_date_cannot_be_in_the_past
  validate :end_time_cannot_be_before_start_time
  # validates :start_time, presence: true
  validates :movement, presence: true
  validates :event_type, presence: true

  has_attached_file :image,
                    :styles => { :medium => '280x150', :thum => '50x50' },
                    :default_url => 'congo.jpg',
                    :url => ':s3_path_url',
                    path: "attachments/event/:id/:style/:filename"

  validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
  validates_attachment_size :image, :less_than => 5.megabytes

  has_attached_file :flyer,
                    :styles => { :medium => '280x150', :thum => '50x50' },
                    :default_url => 'poster2013.jpg',
                    :url => ':s3_path_url',
                    path: "attachments/event_flyer/:id/:style/:filename"

  validates_attachment_content_type :flyer, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']

  validates_attachment_size :flyer, :less_than => 5.megabytes

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

  def self.public_events
    Event.where("start_time > ? AND approved = ?", Date.today, true).sort_by &:start_time
  end

  def type
    event_type.name
  end

  def time_tbd; end

  def location_tbd; end

  def number_of_attendees
    attendees.count
  end

  def status
    "#{host_tasks.where(completed: true).count} / #{host_tasks.count}"
  end

  def attended_by? user
    attendees.include? user
  end

  def host_tasks
    tasks.where(host_task: true)
  end

  def task_assignments
    attendances.map(&:assignments).flatten
  end

  def location
    [address, address2, city, state, zip, country].reject{|i| i.nil? || i.empty? || i == "TBD"}.join(", ")
  end

  def assign_host_and_approve user
    self.update(approved: (self.movement.users.reload.include?(user)), host: user)
  end

  def threshold_size?
    [10, 50].include? self.number_of_attendees
  end

  def to_param
    name.parameterize + '-' + id.to_s
  end

  def self.find_by_param input
    id = input.split('-').pop.to_i
    find id unless id == 0
  end

  def host? user
    user && self.host_id == user.id
  end

  def date; start_date; end

  def start_date
    start_time.to_date if start_time
  end

  def end_date
    end_time.to_date if end_time
  end

  def formatted_time
    if end_time.nil?
      start_time_formatted
    elsif (start_date == end_date)
      build_datetime( "%A, %b %d, %Y,%l:%M %p to", "%l:%M %p")
    else
      build_datetime("%A, %b %d, %Y,%l:%M %p to ", "%A, %b %d, %Y,%l:%M %p")
    end
  end

  def build_datetime(start_date, end_date)
    start_time ? (start_time.strftime(start_date) + end_time.strftime(end_date)) : "TBD"
  end

  def start_time_formatted
    start_time ? start_time.strftime("%b %d, %Y,%l:%M %p") : "TBD"
  end

  def end_time_formatted
    end_time ? end_time.strftime("%b %d, %Y,%l:%M %p") : "TBD"
  end

  def to_csv
    CSV.generate do |csv|
      column_names = ["Name", "Surname", "Email", "Phone", "Volunteer", "Event", "City", "Zip"]
      csv << column_names
      self.attendances.each do |attendance|
      	if attendance.point_person
        	csv << [attendance.user.name, attendance.user.surname, attendance.user.email, attendance.user.phone, attendance.user.volunteer_for(self), attendance.event.name, attendance.event.city, attendance.event.zip] if (attendance.event && attendance.user)
      	else
      		csv << [attendance.user.name, attendance.user.surname, "N/A", "N/A", attendance.user.volunteer_for(self), attendance.event.name, attendance.event.city, attendance.event.zip] if (attendance.event && attendance.user)
      	end
      end
    end
  end

  private
    def assign_coordinates
      if self.latitude.nil? || self.longitude.nil?
        if Rails.env.test?
          self.update_attribute(:latitude, 41.9215421 )
          self.update_attribute(:longitude, -87.70248169999999)
        else
          coordinates = Geocoder.coordinates(location) unless location == "TBD"
          self.update_attribute(:latitude,coordinates.first) unless coordinates.nil?
          self.update_attribute(:longitude,coordinates.last) unless coordinates.nil?
        end
      end
    end

    def populate_tasks
      TaskPopulator.assign_tasks self
      TaskPopulator.assign_host_tasks self
    end

    def end_time_cannot_be_before_start_time
      errors.add(:end_time, "can't be before start time") if (end_time? && start_time) && (end_time < start_time)
    end

    def start_date_cannot_be_in_the_past
      errors.add(:start_date, "can't be in the past") if !start_date.nil? && start_date < Date.today
    end

end
