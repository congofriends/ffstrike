FactoryGirl.define do
  factory :attendee do
    name {Faker::Name.first_name}              
    email {Faker::Internet.email}
    movement
    event

    factory :attendee_with_phone_number do
      phone_number {Faker::PhoneNumber.cell_phone}
    end
  end

  factory :attendee_without_email, class: Attendee do
    name {Faker::Name.first_name}              
    event
    movement
  end

end
