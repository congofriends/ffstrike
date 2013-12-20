FactoryGirl.define do
  factory :new_rally, class: Rally do
  end
  
  factory :invalid_rally, class: Rally do
    notes "I am invalid because I have only a notes attribute"
  end

  factory :rally do
    name 'Super rally'
    id {rand(1000).to_s}
    address '333 North Pole Road'
    city 'Chicago'
    zip '60606'
    notes 'i am a valid rally'
    association :coordinator, factory: :user
  end
end
