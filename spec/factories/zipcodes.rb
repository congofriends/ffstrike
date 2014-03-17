FactoryGirl.define do
  factory :zipcode do
    zip {Faker::Address.zip}
    latitude {Faker::Address.latitude}
    longitude {Faker::Address.longitude}
  end
end
