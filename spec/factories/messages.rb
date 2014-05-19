FactoryGirl.define do
  factory :message do
    name {Faker::Name.first_name}
    email {Faker::Internet.email}
    subject {Faker::Lorem.sentence}
    body {Faker::Lorem.sentence}
  end
end
