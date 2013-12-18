FactoryGirl.define do
  factory :task_without_description, class: Task do
    id {rand(1000).to_s}
  end
end
