class Assignment < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :task
  validates :attendance, presence: true
  validates :task, presence: true

  def attendee
  	attendance.user
  end

end
