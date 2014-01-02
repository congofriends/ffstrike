# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FactoryGirl.create_list(:movement, 20)
FactoryGirl.create_list(:rally, 20)
FactoryGirl.create_list(:task, 20)
FactoryGirl.create_list(:user, 20)
FactoryGirl.create_list(:attendee, 20)
