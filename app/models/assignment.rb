#  change associaton
class Assignment < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :task
  validates :user, presence: true
  validates :task, presence: true
end
