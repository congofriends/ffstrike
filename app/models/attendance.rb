class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :assignments, dependent: :destroy

  validates :user, presence: true
  validates :event, presence: true

  def assign! task
    assignments.where(task_id: task.id).first_or_create!(task_id: task.id)
  end

  def unassign! task
    assignments.find_by(task_id: task.id).destroy
  end

end
