FactoryGirl.define do
  factory :task do
    description "I am a valid task for rally"
    movement
  end

  factory :task_without_description, class: Task do
  end

  factory :task_with_description_longer_than_250_characters, class: Task do
    description {251.times.map{ ('a'..'z').to_a.sample }.join}
    movement_id '1' 
  end

  factory :task_with_description_250_characters, class: Task do
    description {250.times.map{ ('a'..'z').to_a.sample }.join}
    movement_id '1' 
  end
end
