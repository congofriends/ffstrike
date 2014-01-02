class Rally < ActiveRecord::Base
  validates_presence_of :coordinator, :address, on: :create
  belongs_to :coordinator, class_name: User
  belongs_to :movement, class_name: Movement
  has_many :attendees, dependent: :destroy
end
