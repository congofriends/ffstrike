class Attachment < ActiveRecord::Base
	# has_attached_file :flyer

	belongs_to :event
	belongs_to :movement
	# validates_attachment_content_type :flyer, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
