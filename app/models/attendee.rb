class Attendee < ActiveRecord::Base
  belongs_to :event, class_name: Event
  #FIXME: why do we have movement if it is always nil 
  belongs_to :movement

  validates :email, presence: true
  validates :event, presence: true
  has_many :assignments, foreign_key: "attendee_id"
  has_many :assigned_tasks, through: :assignments, source: :task

  def assign! task
    assignments.create(task_id: task.id)
  end

  def unassign! task
    assignments.find_by(task_id: task.id).destroy
  end
end
