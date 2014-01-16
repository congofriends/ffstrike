FactoryGirl.define do
  factory :user do
    email { "#{10.times.map{ ('a'..'z').to_a.sample }.join}@example.com" }
    password 'password'
  end
end
