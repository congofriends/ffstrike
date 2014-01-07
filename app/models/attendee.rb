class Attendee < ActiveRecord::Base
  belongs_to :rally, class_name: Rally
  validates :email, presence: true
  validates :rally_id, presence: true
end
