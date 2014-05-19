namespace :db do
  desc "Fill database with FOTC data"

  task make_fotc: :environment do
    fotc_data = YAML.load_file(Rails.root.join("config", "fotc_data.yml"))
    fotc_events = YAML.load_file(Rails.root.join("config", "fotc_events.yml"))
    fotc_chapters = YAML.load_file(Rails.root.join("config", "fotc_chapters.yml"))
    chapter_events = YAML.load_file(Rails.root.join("config", "chapter_events.yml"))

    def create_event(params, movement, coordinator, number_of_attendees)
      event = movement.events.where(name: params["name"]).first_or_create!(
        params.merge({
          host_id: coordinator.id,
          start_time: DateTime.new(2015, 05, 16, 15, 30),
          end_time: DateTime.new(2015, 05, 16, 17, 30),
          host_id: coordinator.id}))
      number_of_attendees.times do
        FactoryGirl.create(:attendee, movement: movement, event: event)
      end
    end

    def create_chapter(params, parent_movement, host)
      chapter = Movement.where(name: params["name"]).first_or_create!(
        params.merge(parent_id: parent_movement.id))
      chapter.users << host unless chapter.users.include? host
      return chapter
    end



    coordinator = User.where(email: fotc_data["fotc_coordinator"]["email"]).first_or_create!(fotc_data["fotc_coordinator"])
    movement = Movement.where(name: fotc_data["fotc"]["name"]).first_or_create!(fotc_data["fotc"])

    movement.users << coordinator unless movement.users.include? coordinator


    fotc_events.each do |event|
      create_event(event, movement, coordinator, rand(6))
    end


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

    submovement_owner = User.where(email: "subowner@example.com").first_or_create!(name: "subowner",
                                   email: "subowner@example.com",
                                   password: "password",
                                   password_confirmation: "password")


    chapter1 = create_chapter(fotc_chapters.first, movement, coordinator)
    chapter2 = create_chapter(fotc_chapters.second, movement, submovement_owner)


    fotc_chapters.each do |chapter|
      create_chapter(chapter, movement, submovement_owner)
    end

    create_event(chapter_events[0], chapter1, coordinator, 5)
    create_event(chapter_events[1], chapter2, coordinator, 5)


 end
end

