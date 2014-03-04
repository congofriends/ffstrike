FactoryGirl.define do
  factory :event_without_address, class: Event do
    notes "I am invalid because I have only a notes attribute"
    event_type_id {EventType.all.map(&:id).sample}
  end

  factory :event do
    name {10.times.map{('a'..'z').to_a.sample}.join}
    address '333 North Pole Road'
    location_details 'meet in the corner'
    city 'Chicago'
    zip '60606'
    date '08/02/90'
    time '22:35'
    notes 'i am a valid event'
    association :host, factory: :user
    approved false
    event_type_id {EventType.all.map(&:id).sample}
    movement

    factory :approved_event do
      approved true
    end
  end
end
