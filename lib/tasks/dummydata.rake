namespace :db do
  desc "Fill database with FOTC data"
  task make_fotc: :environment do
    data = YAML.load_file(Rails.root.join("config", "fotc_data.yml"))

    coordinator = User.where(email: data["fotc_coordinator"]["email"]).first_or_create!(data["fotc_coordinator"])

    movement = Movement.where(name: data["fotc"]["name"]).first_or_create!(data["fotc"])

    movement.users << coordinator unless movement.users.include? coordinator

    fotc_event1 = movement.events.where(name: data["fotc_event1"]["name"]).first_or_create!(
        data["fotc_event1"].merge({
        host_id: coordinator.id,
        start_time: DateTime.new(2015, 05, 16, 15, 30),
        end_time: DateTime.new(2015, 05, 16, 17, 30),
        host_id: coordinator.id}))

   fotc_event2 = movement.events.where(name: data["fotc_event2"]["name"]).first_or_create!(
       data["fotc_event2"].merge({
       host_id: coordinator.id,
       start_time: DateTime.new(2015, 05, 14, 15, 30),
       end_time: DateTime.new(2015, 05, 14, 17, 30),
       host_id: coordinator.id}))

   fotc_event3 = movement.events.where(name: data["fotc_event3"]["name"]).first_or_create!(
       data["fotc_event3"].merge({
       host_id: coordinator.id,
       start_time: DateTime.new(2015, 05, 14, 15, 30),
       end_time: DateTime.new(2015, 05, 14, 17, 30),
       host_id: coordinator.id}))

   fotc_event4 = movement.events.where(name: data["fotc_event4"]["name"]).first_or_create!(
       data["fotc_event4"].merge({
       host_id: coordinator.id,
       start_time: DateTime.new(2015, 05, 14, 15, 30),
       end_time: DateTime.new(2015, 05, 14, 17, 30),
       host_id: coordinator.id}))

   fotc_event5 = movement.events.where(name: data["fotc_event5"]["name"]).first_or_create!(
       data["fotc_event5"].merge({
       host_id: coordinator.id,
       start_time: DateTime.new(2015, 05, 14, 15, 30),
       end_time: DateTime.new(2015, 05, 14, 17, 30),
       host_id: coordinator.id}))

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

    sub_movement1 = Movement.where(name: data["sub_movement1"]["name"]).first_or_create!(
        data["sub_movement1"].merge(
        parent_id: movement.id)
)

    sub_movement1.users << coordinator unless sub_movement1.users.include? coordinator

    submovement_owner = User.where(email: "subowner@example.com").first_or_create!(name: "subowner",
                                   email: "subowner@example.com",
                                   password: "password",
                                   password_confirmation: "password")

    sub_movement2 = Movement.where(name: data["sub_movement2"]["name"]).first_or_create!(
        data["sub_movement2"].merge(parent_id: movement.id))

    sub_movement2.users << submovement_owner unless sub_movement2.users.include? submovement_owner

    sub_movement3 = Movement.where(name: data["sub_movement3"]["name"]).first_or_create!(
        data["sub_movement3"].merge(parent_id: movement.id))

    sub_movement3.users << submovement_owner unless sub_movement3.users.include? submovement_owner

    sub_movement4 = Movement.where(name: data["sub_movement4"]["name"]).first_or_create!(
        data["sub_movement4"].merge(parent_id: movement.id))

    sub_movement4.users << submovement_owner unless sub_movement4.users.include? submovement_owner

    sub_movement5 = Movement.where(name: data["sub_movement5"]["name"]).first_or_create!(
        data["sub_movement5"].merge(parent_id: movement.id))

    sub_movement5.users << submovement_owner unless sub_movement5.users.include? submovement_owner

    sub_movement6 = Movement.where(name: data["sub_movement6"]["name"]).first_or_create!(
        data["sub_movement6"].merge(parent_id: movement.id))

    sub_movement6.users << submovement_owner unless sub_movement6.users.include? submovement_owner

    sub_movement7 = Movement.where(name: data["sub_movement7"]["name"]).first_or_create!(
        data["sub_movement7"].merge(parent_id: movement.id))

    sub_movement7.users << submovement_owner unless sub_movement7.users.include? submovement_owner

    sub_movement8 = Movement.where(name: data["sub_movement8"]["name"]).first_or_create!(
        data["sub_movement8"].merge(parent_id: movement.id))

    sub_movement8.users << submovement_owner unless sub_movement8.users.include? submovement_owner

   sub_movement9 = Movement.where(name: data["sub_movement9"]["name"]).first_or_create!(
        data["sub_movement9"].merge(parent_id: movement.id))

    sub_movement9.users << submovement_owner unless sub_movement9.users.include? submovement_owner

   sub_movement10 = Movement.where(name: data["sub_movement10"]["name"]).first_or_create!(
        data["sub_movement10"].merge(parent_id: movement.id))

    sub_movement10.users << submovement_owner unless sub_movement10.users.include? submovement_owner




    sub_movement1.events.where(name: "Screening The Congolese Tragedy: From Causes to Sustainable Solutions").first_or_create!(
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

     sub_movement2.events.where(name: "Discussion: The Crisis of Sexual Violence and Rape as a Weapon of War").first_or_create!(
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
