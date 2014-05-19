class Assignment < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :task
  validates :attendee, presence: true
  validates :task, presence: true
end
