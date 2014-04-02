# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Zipcode.destroy_all
EventType.destroy_all
EventType.reset_pk_sequence

EVENT_DESCRIPTIONS["event_type"].keys.each { |key| EventType.create(name: key.gsub(/_/, ' ').camelize) }

# Load Zipcodes beginning with 6
file = "lib/assets/US.txt"
puts "loading zip codes from #{file}"
File.foreach(file) do |line|
  data = line.split("\t")
  if data[1][0] == "6"
    Zipcode.create(zip: data[1], city: data[2], state: data[3], state_abbreviation: data[4], latitude: data[10].to_f, longitude: data[9].to_f)
  end
end

