FactoryGirl.define do
  factory :attendee do
    email "email@example.com"
    movement
    event
  end

  factory :attendee_without_email, class: Attendee do
    name "Harry Potter"
    event
    movement
  end
end
