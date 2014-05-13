namespace :db do
  desc "Fill database with sample data"
  task make_cats: :environment do

    coordinator = User.where(email: "coordinator@example.com").first_or_create!(name: "coordinator",
                               email: "coordinator@example.com",
                               password: "password",
                               password_confirmation: "password")

    movement = Movement.where(name: "We Love Cats!").first_or_create!(
        name: "We Love Cats!",
        tagline: "Empowering the world through love of cats!",
        call_to_action: "Get your cat and help us change the world!",
        published: true,
        extended_description: "We love cats.  We know you love cats to.  Together, we can use our feline friends to change the world.")

    movement.users << coordinator

    coordinator_event = movement.events.create!(
        host_id: coordinator.id,
        name: "Speak Out for Cats",
        address: "Aon Center",
        city: "Chicago",
        zip: "60647",
        start_time: DateTime.new(2015, 05, 16, 15, 30),
        end_time: DateTime.new(2015, 05, 16, 17, 30),
        event_type_id: 1,
        approved: true,
        event_type_id: 1,
        host_id: coordinator.id)

    task = coordinator_event.tasks.create!(
        description: "Bring your cat!")

    attendee = coordinator_event.attendees.create!(
        email: "attendee@example.com",
        phone_number: "1234567890",
        point_person: false)

    non_coordinator = User.where(email: "noncoordinator@example.com").first_or_create!(name: "noncoordinator",
                                   email: "noncoordinator@example.com",
                                   password: "password",
                                   password_confirmation: "password")

    non_coordinator_event = movement.events.create!(
        name: "Rally for Cats",
        address: "Aon Center",
        city: "Chicago",
        zip: "60647",
        start_time: DateTime.new(2015, 05, 16, 15, 30),
        end_time: DateTime.new(2015, 05, 16, 17, 30),
        event_type_id: 2,
        approved: false,
        host_id: non_coordinator.id)
  end

  desc "Fill database with FOTC data"
  task make_fotc: :environment do
    coordinator = User.where(email: "coordinator@friendsofthecongo.org").first_or_create!(name: "FOTC_coordinator",
                                                                                          email: "coordinator@friendsofthecongo.org",
                                                                                          password: "password",
                                                                                          password_confirmation: "password")

    movement = Movement.where(name: "Friends of the Congo").first_or_create!(
        name: "Friends of the Congo",
        tagline: "Crisis in the Congo: Uncovering the Truth",
        call_to_action: "Raising consciousness about the challenge of the Congo and supporting Congolese institutions as they strive to bring about peaceful and lasting change",
        published: true,
        video: "vLV9szEu9Ag",
        extended_description: "Imagine that millions have been killed and continue to die, hundreds of thousands of women have been systematically raped and are still being brutalized, corporate plundering reigns, the 2nd largest rainforest in the world, being destroyed and mass crimes have been committed and remain widespread - yet the world has been deadly silent. This is modern-day Congo. Join the global movement - Break the Silence!",
        location: "Global")

    movement.users << coordinator unless movement.users.include? coordinator

    fotc_event1 = movement.events.where(name: "Crisis in the Congo: Building Solidarity in Southern Africa").first_or_create!(
        host_id: coordinator.id,
        name: "Crisis in the Congo: Building Solidarity in Southern Africa",
        address: "200 E Randolph St",
        city: "Chicago",
        zip: "60634",
        state: "IL",
        start_time: DateTime.new(2015, 05, 16, 15, 30),
        end_time: DateTime.new(2015, 05, 16, 17, 30),
        event_type_id: 1,
        approved: true,
        host_id: coordinator.id)

   fotc_event2 = movement.events.where(name: "Break the Silence for Congo Women").first_or_create!(
        host_id: coordinator.id,
        name: "Break the Silence for Congo Women",
        address: "265 Chatham Drive",
        city: "Chapel Hill",
        zip: "27516",
        state: "NC",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 3,
        approved: true,
        host_id: coordinator.id)

   fotc_event3 = movement.events.where(name: "Crisis in the Congo: Uncovering the Truth").first_or_create!(
        host_id: coordinator.id,
        name: "Crisis in the Congo: Uncovering the Truth",
        address: "409 Riverside Drive",
        city: "New York",
        zip: "10027",
        state: "NY",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 4,
        approved: true,
        host_id: coordinator.id)

    attendee = fotc_event1.attendees.create!(
        email: "dpark@example.com",
        phone_number: "1234567890",
        point_person: false)

    non_coordinator = User.where(email: "noncoordinator@example.com").first_or_create!(name: "noncoordinator",
                                   email: "noncoordinator@example.com",
                                   password: "password",
                                   password_confirmation: "password")

    non_coordinator_event = movement.events.where(name: "FOTC info session").first_or_create!(
        name: "FOTC info session",
        address: "700 W Van Buren",
        city: "Chicago",
        zip: "60634",
        state: "IL",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 2,
        approved: true,
        host_id: non_coordinator.id)

    sub_movement1 = Movement.where(name: "Break the Silence").first_or_create!(
        name: "Break the Silence",
        tagline: "Crisis in the Congo: Uncovering the Truth",
        call_to_action: "Each and everyone of us can do something to bring an end to the suffering in the Congo and work with our Congolese brothers and sisters to bring about change.",
        published: true,
        parent_id: movement.id,
        video: "vLV9szEu9Ag",
        extended_description: "People throughout the globe are taking action and Friends of Congo is amassing the diverse actions to build a unified global movement in support of the Congo. Youth in Japan have organized forums, students in New Zealand have held demonstrations and cell outs, activists in California have passed resolutions in their city councils, house wives in Minnesota have raised funds, grandmothers in Tennessee have written to corporations, professionals in Washington State have divested from bad acting corporations, musicians in Columbia South America have written songs, journalists in Sweden have translated documents and much more is happening than we can list on this page.",
        location: "Global")

    sub_movement1.users << coordinator unless sub_movement1.users.include? coordinator

    submovement_owner = User.where(email: "subowner@example.com").first_or_create!(name: "subowner",
                                   email: "subowner@example.com",
                                   password: "password",
                                   password_confirmation: "password")

    sub_movement2 = Movement.where(name: "Conflict Minerals Petition Day").first_or_create!(
        name: "Conflict Minerals Petition Day",
        tagline: "Crisis in the Congo: Uncovering the Truth",
        call_to_action: "We encourage you to bring your talents, skills, expertise, interests, knowledge to be a part of the global movement in support of the Congo",
        published: true,
        parent_id: movement.id,
        video: "89rKdJjumdA",
        extended_description: "An historic opportunity exists for ordinary people throughout the globe to participate in a global movement in partnership with the Congolese people as they strive to establish a peaceful and prosperous Congo wherein current and future generations are able to fulfill their enormous human and natural potential.",
        location: "Global")

    sub_movement2.users << submovement_owner unless sub_movement2.users.include? submovement_owner

    sub_movement1.events.where(name: "The Congolese Tragedy: From Causes to Sustainable Solutions").first_or_create!(
        name: "The Congolese Tragedy: From Causes to Sustainable Solutions",
        address: "720 Rutland Avenue",
        city: "Baltimore",
        zip: "21205",
        state: "MD",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 3,
        approved: true,
        host_id: coordinator.id)

     sub_movement2.events.where(name: "The Crisis of Sexual Violence and Rape as a Weapon of War").first_or_create!(
        name: "The Crisis of Sexual Violence and Rape as a Weapon of War",
        address: "152 Pearl Street",
        city: "Burlington",
        zip: "05401",
        state: "VT",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 4,
        approved: true,
        host_id: coordinator.id)
 end
end
