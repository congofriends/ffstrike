class Task < ActiveRecord::Base
  belongs_to :rally
  validates :description, length: { maximum: 250, minimum: 1 }
  validates :rally_id, presence: true
end
