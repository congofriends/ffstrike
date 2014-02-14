class Task < ActiveRecord::Base
  belongs_to :event, class_name: Event
  validates :event_id, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  has_many :assignments, foreign_key: "task_id"
  has_many :assigned_attendees, through: :assignments, source: :attendee

  def assigned? attendee
    assignments.find_by(attendee_id: attendee.id)
  end

  def assign! attendee_id
    assignments.create(attendee_id: attendee_id)
  end

  def unassign! attendee
   assignments.find_by(attendee_id: attendee.id).destroy 
  end

  def is_assigned_to? account
    self.assignments.map {|a| a.attendee_id == account.id }.any? 
  end

end
