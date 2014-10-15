class EventType < ActiveRecord::Base
	has_many :events

	has_attached_file 	:image,
						:styles => { :medium => '280x150', :thum => '50x50' },
						:default_url => 'congo.jpg'

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  	validates_attachment_size :image, :less_than => 5.megabytes
	
	def self.names
		all.map(&:name)
	end


end
