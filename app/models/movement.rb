class Movement < ActiveRecord::Base
  validates_with VideoValidator, fields: [:video]
  has_many :events, dependent: :destroy
  #has_many :attendees, through: :events #, source: :user
  has_many :attendances, through: :events #, source: :user
  has_many :ownerships, dependent: :destroy
  has_many :users, through: :ownerships
  validates :name, uniqueness: true
  validates :name, presence: true

  has_attached_file :image,
                    :styles => { :medium => '280x150', :thum => '50x50' },
                    :default_url => 'congo_banner.jpg'


  validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
  validates_attachment_size :image, :less_than => 5.megabytes

  has_attached_file :avatar,
                    :styles => { :medium => '280x150', :thum => '50x50' },
                    :default_url => 'break_the_silence.jpg'

  validates_attachment_content_type :avatar, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
  validates_attachment_size :avatar, :less_than => 5.megabytes

  scope :published, lambda {where(published: true)}
  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}

  alias_attribute :movement_name, :name

  attr_accessor :draft

  def to_param
    name.gsub(/ /, '-')
  end

  def self.find_by_param input
    find_by_name input.gsub(/-/, ' ')
  end

  def sub_movements
    Movement.where(parent_id: self.id)
  end

  def parent
    Movement.find(self.parent_id ) if self.parent_id
  end

  def parent?
    parent.nil?
  end

  def attendees
    User.find(attendances.map(&:user_id).uniq)
  end

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
    where(published: true).offset(rand(where(published: true).count - number_of_events + 1)).first(number_of_events)
  end

  def number_of_attendees
    movement_events.inject(0) { |sum, event| sum+event.attendees.count }
  end

  def authorized?(user)
    (self.users.include?(user))||(self.published?)
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
      self.attendances.each do |attendance|
        csv << [attendance.user.name, attendance.user.email, attendance.user.phone, attendance.event.name, attendance.event.city, attendance.event.zip] if (attendance.event && attendance.user)
      end
    end
  end

end
