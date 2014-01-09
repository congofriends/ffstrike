class Task < ActiveRecord::Base
  belongs_to :movement
  validates :movement_id, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validate :at_least_one_rally_size
  # has_and_belongs_to_many :attendees
  has_many :assignments, foreign_key: "task_id"
  has_many :assigned_attendees, through: :assignments, source: :attendee

  scope :tasks_for, -> (rally_type){where(rally_type => true)}

  def assigned? attendee
    assignments.find_by(attendee_id: attendee.id)
  end

  def assign! attendee
    assignments.create(attendee_id: attendee.id)
  end

  def unassign! attendee
   assignments.find_by(attendee_id: attendee.id).destroy 
  end

  private
  def at_least_one_rally_size
    if [self.small_rally, self.medium_rally, self.big_rally].reject(&:blank?).size == 0
      errors[:rally_size_warning] << "Please choose at least one rally category"
    end
  end
end
