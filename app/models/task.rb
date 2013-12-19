class Task < ActiveRecord::Base
  belongs_to :movement
  validates :movement_id, presence: true
  validates :description, length: { maximum: 250, minimum: 1 }
end
