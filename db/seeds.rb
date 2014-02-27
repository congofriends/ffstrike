# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

types = %w(Rally Public\ speak\ out Movie\ screening Public\ forum Meet\ with\ decision\ maker Planning\ meeting Own\ event)
types.each { |type| EventType.create(name: type)  }

# Load Zipcodes beginning with 6
file = "lib/assets/US.txt"
puts "loading zip codes from #{file}"
File.foreach(file) do |line|
  data = line.split("\t")
  if data[1][0] == "6"
    Zipcode.create(zip: data[1], city: data[2], state: data[3], state_abbreviation: data[4], latitude: data[10].to_f, longitude: data[9].to_f)
  end
end

