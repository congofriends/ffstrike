class EventType < ActiveRecord::Base
	has_many :events

	def self.names
		all.map(&:name)
	end

	def formatted_name
		name.parameterize
	end

end
