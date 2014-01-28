FactoryGirl.define do
  factory :task do
    description "I am a valid task for event"
    event
    small_event true
  end

  factory :task_without_description, class: Task do
    event
    small_event true
  end

  factory :task_without_event_size, class: Task do
    description {'description '*2}
    event
  end

  factory :task_with_description_longer_than_250_characters, class: Task do
    description {251.times.map{ ('a'..'z').to_a.sample }.join}
    event
    small_event true
  end

  factory :task_with_description_250_characters, class: Task do
    description {250.times.map{ ('a'..'z').to_a.sample }.join}
    event
    small_event true
  end
end
