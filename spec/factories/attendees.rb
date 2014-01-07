FactoryGirl.define do
  factory :attendee do
    email "email@example.com"
    movement
    rally
  end

  factory :attendee_without_email, class: Attendee do
    name "Harry Potter"
    rally
    movement
  end
end
