class Movement < ActiveRecord::Base
  validates_with VideoValidator, fields: [:video]
  validates_presence_of :name, on: :create 
  has_many :tasks, dependent: :destroy

  has_attached_file :image, :default_url => 'cat.png'
	validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
	validates_attachment_size :image, :less_than => 2.megabytes
  
  has_many :users

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

end
