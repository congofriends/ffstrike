FactoryGirl.define do
  factory :event_without_address, class: Event do
    date '2014-04-25'
    notes {Faker::Lorem.paragraph}
    event_type_id {EventType.all.map(&:id).sample}
  end

  factory :event do
    name {Faker::Lorem.words.join(' ')}
    address {Faker::Address.street_address}
    location_details {Faker::Lorem.sentence}
    city {Faker::Address.city}
    zip {Faker::Address.zip}
    state {Faker::Address.state}
    date '2014-04-25'
    time '22:35'
    notes {Faker::Lorem.sentence}  
    association :host, factory: :user
    approved false
    event_type_id {EventType.all.map(&:id).sample}
    movement

    factory :approved_event do
      approved true
    end
  end

  factory :invalid_event, class: Event do
    name {Faker::Lorem.words.join(' ')}
    location_details {Faker::Lorem.sentence}
    city {Faker::Address.city}
    zip {Faker::Address.zip}
    state {Faker::Address.state}
    date '2014-04-25'
    time '22:35'
    notes {Faker::Lorem.sentence}  
    approved false
    event_type_id {EventType.all.map(&:id).sample}
    movement
  end
end
