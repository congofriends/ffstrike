FactoryGirl.define do
  factory :invalid_event, class: Event do
    notes "I am invalid because I have only a notes attribute"
    event_type_id 2
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
    association :host, factory: :user
    approved true
    event_type_id 2
    movement
  end
end
