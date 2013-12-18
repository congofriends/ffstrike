FactoryGirl.define do
  factory :task_without_description, class: Task do
    id {rand(1000).to_s}
  end

  factory :task_with_description_longer_than_250_characters, class: Task do
    id {rand(1000).to_s}
    description {251.times.map{ ('a'..'z').to_a.sample }.join}
    rally_id {rand(1000).to_s}
  end

  factory :task_with_description_250_characters, class: Task do
    id {rand(1000).to_s}
    description {250.times.map{ ('a'..'z').to_a.sample }.join}
    rally_id {rand(1000).to_s}
  end
end
