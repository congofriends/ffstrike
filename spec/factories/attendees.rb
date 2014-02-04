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

  factory :attendee_with_phone_number, class: Attendee do
    name "Lord Voldemort"
    email "email@example.com"
    phone_number 986-345-9098
    movement
    event
  end
end
