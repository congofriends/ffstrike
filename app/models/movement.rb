class Movement < ActiveRecord::Base
  validates_with VideoValidator, fields: [:video]
  validates_presence_of :name, on: :create 
  has_many :tasks, dependent: :destroy
  has_many :rallies, dependent: :destroy
  has_many :attendees
  belongs_to :user
  validates_presence_of :user, on: :create

  has_attached_file :image, :default_url => 'cat.png'
	validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
	validates_attachment_size :image, :less_than => 2.megabytes
  
  has_many :users
  alias_attribute :movement_name, :name

  def movement_rallies
    self.rallies  
  end

  def movement_tasks
    self.tasks
  end

  def count_movement_tasks
    self.movement_tasks.count
  end

  def tasks_for(rally_size)
    self.movement_tasks.tasks_for(rally_size)
  end

  def count_tasks(rally_size)
    self.tasks_for(rally_size).count
  end

  def self.random(number_of_rallies = 1)
    Movement.offset(rand(Movement.count - number_of_rallies + 1)).first(number_of_rallies) 
  end

  def to_csv
    CSV.generate do |csv|
      column_names = ["Name", "Email", "Phone", "Rally", "Zip", "City"]
      csv << column_names
      self.attendees.each do |attendee|
        csv << [attendee.name, attendee.email, attendee.phone, attendee.rally.name, attendee.rally.zip, attendee.rally.city] 
      end
    end
  end

end
