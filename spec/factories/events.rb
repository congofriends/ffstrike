FactoryGirl.define do
  factory :new_event, class: Event do
  end
  
  factory :invalid_event, class: Event do
    notes "I am invalid because I have only a notes attribute"
  end

  factory :event do
    name 'Super event'
    address '333 North Pole Road'
    location_details 'meet in the corner'
    city 'Chicago'
    zip '60606'
    date '08/02/90'
    time '22:35'
    notes 'i am a valid event'
    association :coordinator, factory: :user
    approved true
    movement
  end
end
