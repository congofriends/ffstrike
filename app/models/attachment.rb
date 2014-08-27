class Attachment < ActiveRecord::Base
	belongs_to :event
	belongs_to :movement
end
