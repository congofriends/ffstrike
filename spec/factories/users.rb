FactoryGirl.define do
  factory :user do
    name {Faker::Name.first_name}
    email {Faker::Internet.email}
    password 'password'
  end

  factory :invalid_user, class: User do
    email {Faker::Internet.email}
  end
  
end
