class Rally < ActiveRecord::Base
  validates_presence_of :coordinator, :address, on: :create
  belongs_to :coordinator, class_name: User
end
