FactoryGirl.define do
  factory :attendance do
  	user
  	event
  	point_person true
  	notes {Faker::Lorem.sentence}
  end
end
