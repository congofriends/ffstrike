FactoryGirl.define do
  factory :attendee do
    name "Lord Voldemort"
    email "email@example.com"
    movement
    event

    factory :attendee_with_phone_number do
      phone_number 9863459098
    end
  end

  factory :attendee_without_email, class: Attendee do
    name "Harry Potter"
    event
    movement
  end

end
