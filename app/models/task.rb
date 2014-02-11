class Task < ActiveRecord::Base
  belongs_to :event, class_name: Event
  validates :event_id, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validate :at_least_one_event_size
  has_many :assignments, foreign_key: "task_id"
  has_many :assigned_attendees, through: :assignments, source: :attendee

  scope :tasks_for, -> (event_type){where(event_type => true)}

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


  private
  def at_least_one_event_size
    if [self.small_event, self.medium_event, self.big_event].reject(&:blank?).size == 0
      errors[:event_size_warning] << "Please choose at least one event category"
    end
  end
end
