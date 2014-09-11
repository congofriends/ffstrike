Zipcode.destroy_all
EventType.destroy_all
EventType.reset_pk_sequence

EVENT_DESCRIPTIONS["event_type"].keys.each { |key| EventType.create(name: key.gsub(/_/, ' ').titleize) }

puts "my environment is " + Rails.env