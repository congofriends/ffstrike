FactoryGirl.define do
  factory :event_without_address, class: Event do
    notes {Faker::Lorem.paragraph}
    event_type_id {EventType.all.map(&:id).sample}
    latitude 41.9215421
    longitude -87.70248169999999
    start_time DateTime.now+1000
    end_time DateTime.now + 10000
  end

  factory :event do
    name {Faker::Lorem.words.join(' ')}
    address {Faker::Address.street_address}
    location_details {Faker::Lorem.sentence}
    city {Faker::Address.city}
    zip {Faker::Address.zip}
    state {Faker::Address.state}
    start_time DateTime.now + 1000
    end_time DateTime.now + 16000
    latitude 41.9215421
    longitude -87.70248169999999
    notes {Faker::Lorem.sentence}
    association :host, factory: :user
    approved false
    event_type_id {EventType.all.map(&:id).sample}
    movement

    factory :approved_event do
      approved true
    end

    factory :event_with_passed_date, class: Event do
      start_time DateTime.now - 10000
      end_time DateTime.now + 6000
    end

    factory :event_with_end_time_before_start_time, class: Event do
      start_time DateTime.now + 10000
      end_time DateTime.now - 6000
    end

    factory :event_without_date, class: Event do
    end
  end

  factory :invalid_event, class: Event do
    name {Faker::Lorem.words.join(' ')}
    location_details {Faker::Lorem.sentence}
    start_time DateTime.now - 10000
    end_time DateTime.now + 16000
    latitude 41.9215421
    longitude -87.70248169999999
    notes {Faker::Lorem.sentence}
    approved false
    event_type_id {EventType.all.map(&:id).sample}
    movement
  end
end
