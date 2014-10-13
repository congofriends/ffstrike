class EventType < ActiveRecord::Base
	has_many :events

	has_attached_file 	:image,
						:styles => { :medium => '280x150', :thum => '50x50' },
						:default_url => 'congo.jpg'

	def self.names
		all.map(&:name)
	end


end
