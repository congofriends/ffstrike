FactoryGirl.define do
  factory :new_event, class: Event do
  end
  
  factory :invalid_event, class: Event do
    notes "I am invalid because I have only a notes attribute"
  end

  factory :event do
    name 'Super event'
    address '333 North Pole Road'
    city 'Chicago'
    zip '60606'
    notes 'i am a valid event'
    association :coordinator, factory: :user
  end
end
