FactoryGirl.define do
  factory :event_without_address, class: Event do
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
    date '08/02/90'
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
end
