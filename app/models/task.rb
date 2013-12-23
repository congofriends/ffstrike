class Task < ActiveRecord::Base
  belongs_to :movement
  validates :movement_id, presence: true
  validates :description, presence: true, length: { maximum: 250, minimum: 1 }
  validate :at_least_one_rally_size

  scope :tasks_for, -> (rally_type){where(rally_type => true)}

  private
  def at_least_one_rally_size
    if [self.small_rally, self.medium_rally, self.big_rally].reject(&:blank?).size == 0
      errors[:rally_size_warning] << "Please choose at least one rally category"
    end
  end
end
