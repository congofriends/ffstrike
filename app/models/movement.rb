class Movement < ActiveRecord::Base
  validates_with VideoValidator, fields: [:video]
  validates_presence_of :name, on: :create 
  has_many :events, dependent: :destroy
  has_many :attendees
  belongs_to :user
  validates_presence_of :user, on: :create

  has_attached_file :image, :default_url => 'cat.png'
	validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
	validates_attachment_size :image, :less_than => 2.megabytes

  scope :published, lambda {where(published: true)}
  alias_attribute :movement_name, :name

  attr_accessor :draft

  def movement_events
    self.events  
  end

  def without_events?
    movement_events.empty?
  end

  def publish
    self.update(published: true)
  end

  def self.random(number_of_events = 1)
    Movement.offset(rand(Movement.count - number_of_events + 1)).first(number_of_events) 
  end

  def number_of_attendees
    movement_events.inject(0) { |sum, event| sum+event.attendees.count }
  end

  def locations
    #FIXME: why nil? instead of empty?
    # movement_events.map(&:city).uniq.reject(&:empty?).slice(0..8).join(", ")
    movement_events.map(&:city).uniq.reject(&:nil?).slice(0..8).join(", ")
  end

  def to_csv
    CSV.generate do |csv|
      column_names = ["Name", "Email", "Phone", "Event", "Zip", "City"]
      csv << column_names
      self.attendees.each do |attendee|
        csv << [attendee.name, attendee.email, attendee.phone, attendee.event.name, attendee.event.zip, attendee.event.city] 
      end
    end
  end

end
