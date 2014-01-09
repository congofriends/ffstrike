class Assignment < ActiveRecord::Base
  belongs_to :attendee, class_name: "Attendee"
  belongs_to :task, class_name: "Task"
  validates :attendee_id, presence: true
  validates :task_id, presence: true
end
