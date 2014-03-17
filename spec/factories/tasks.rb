FactoryGirl.define do
  factory :task do
    description {Faker::Lorem.sentence}
    event
  end

  factory :task_without_description, class: Task do
    description ""
    event
  end

  factory :task_with_description_longer_than_250_characters, class: Task do
    description {Faker::Lorem.characters(251)}
    event
  end

  factory :task_with_description_250_characters, class: Task do
    description {Faker::Lorem.characters(250)}
    event
  end
end
