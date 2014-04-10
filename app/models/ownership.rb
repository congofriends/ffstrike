class Ownership < ActiveRecord::Base
  belongs_to :user
  belongs_to :movement
  validates_presence_of :user_id
  validates_presence_of :movement_id
end
