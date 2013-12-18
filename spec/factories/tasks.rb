FactoryGirl.define do
  factory :task do
    description "I am a valid task for rally"
    rally
  end

  factory :task_without_description, class: Task do
  end

  factory :task_with_description_longer_than_250_characters, class: Task do
    description {251.times.map{ ('a'..'z').to_a.sample }.join}
    rally_id {rand(1000).to_s}
  end

  factory :task_with_description_250_characters, class: Task do
    description {250.times.map{ ('a'..'z').to_a.sample }.join}
    rally_id {rand(1000).to_s}
  end
end
