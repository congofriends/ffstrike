class Task < ActiveRecord::Base
  belongs_to :event, class_name: Event
  validates :event, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  has_many :assignments, foreign_key: "task_id"

  def assign! user
    attendance = user.attendances.find_by(event_id: self.event_id)
    assignments.create(attendance_id: attendance.id)
  end

  def unassign! user
    attendance = user.attendances.find_by(event_id: self.event_id)
    assignments.find_by(attendance_id: attendance.id).destroy
  end

  def is_assigned_to? user
    return false if user.nil?
    assignments.map {|a| a.attendance.user_id == user.id if a.attendance}.any?

  end

  def assignment_for user
    assignments.map {|a| return a if a.attendance && a.attendance.user_id == user.id }
  end

  def is_not_assigned_to? user
    return false if user.nil?
    assignments.select { |a| a.attendance.user_id == user.id if a.attendance}.empty?
  end

  def is_allowed_to_update_by? user
    return false if user.nil?
    (event.movement.users.include? user) || event.host == user
  end

  def self.host_tasks
    Task.where(host_task: true)
  end

  def volunteers
     return [] unless (assignments.map &:attendance).first
     assignments.map(&:attendance).map(&:user)
  end
end
