class Assignment < ActiveRecord::Base
  belongs_to :attendee, class_name: "Attendee"
  belongs_to :task, class_name: "Task"
  validates :attendee, presence: true
  validates :task, presence: true
end
