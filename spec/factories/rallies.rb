FactoryGirl.define do
  factory :rally do
    id {rand(1000).to_s}
    name "Super rally"
  end
end
