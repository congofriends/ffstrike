namespace :db do
  desc "Fill database with sample data"
  task make_cats: :environment do

    coordinator = User.create!(name: "coordinator",
                               email: "coordinator@example.com",
                               password: "password",
                               password_confirmation: "password")

    movement = coordinator.movements.create!(
        name: "We Love Cats!",
        tagline: "Empowering the world through love of cats!",
        call_to_action: "Get your cat and help us change the world!",
        extended_description: "We love cats.  We know you love cats to.  Together, we can use our feline friends to change the world.")

   coordinator_event = movement.events.create!(
        coordinator_id: coordinator.id,
        name: "Speak Out for Cats",
        address: "Aon Center",
        city: "Chicago",
        zip: "60647",
        date: "02/19/2030",
        time: "9:00 PM",
        event_type_id: 1,
        approved: true,
        host_id: coordinator.id)

    task = coordinator_event.tasks.create!(
        description: "Bring your cat!")

    attendee = coordinator_event.attendees.create!(
        email: "attendee@example.com",
        phone_number: "1234567890",
        point_person: false)

    non_coordinator = User.create!(name: "noncoordinator",
                                   email: "noncoordinator@example.com",
                                   password: "password",
                                   password_confirmation: "password")
    
    non_coordinator_event = movement.events.create!(
        coordinator_id: coordinator.id,
        name: "Rally for Cats",
        address: "Aon Center",
        city: "Chicago",
        zip: "60647",
        date: "02/19/2030",
        time: "9:00 PM",
        event_type_id: 2,
        approved: false,
        host_id: non_coordinator.id)
  end
end
