class Attendee < ActiveRecord::Base
  belongs_to :rally, class_name: Rally
  belongs_to :movement
  validates :email, presence: true
  validates :rally_id, presence: true
end
