class Task < ActiveRecord::Base
  belongs_to :event, class_name: Event
  validates :event, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  has_many :assignments, foreign_key: "task_id"

  def assign! user
    attendance = user.attendances.find_by(event_id: self.event_id)
    assignments.create(attendance_id: attendance.id)
  end

  def is_assigned_to? user
    assignments.map {|a| a.attendance.user_id == user.id }.any?
  end

  def is_not_assigned_to? user
    assignments.select { |a| a.attendance.user_id == user.id }.empty?
  end

  def is_allowed_to_update_by? user
    event.movement.users.include? user
  end
end
