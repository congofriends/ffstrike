namespace :db do
  desc "Fill database with FOTC data"

  task congo_week: :environment do
    fotc_data = YAML.load_file(Rails.root.join("config", "fotc_data.yml"))
    coordinator = User.where(email: fotc_data["fotc_coordinator"]["email"]).first_or_create!(fotc_data["fotc_coordinator"])
    movement = Movement.where(name: fotc_data["fotc"]["name"]).first_or_create!(fotc_data["fotc"])
    movement.users << coordinator unless movement.users.include? coordinator
   end

  task make_fotc: :environment do
    fotc_data = YAML.load_file(Rails.root.join("config", "fotc_data.yml"))
    fotc_events = YAML.load_file(Rails.root.join("config", "fotc_events.yml"))
    fotc_teams = YAML.load_file(Rails.root.join("config", "fotc_teams.yml"))
    team_events = YAML.load_file(Rails.root.join("config", "team_events.yml"))

    def create_event(params, movement, coordinator, number_of_attendees)
      event = movement.events.where(name: params["name"]).first_or_create!(
        params.merge({
          host_id: coordinator.id,
          start_time: DateTime.new(2015, 05, 16, 15, 30),
          end_time: DateTime.new(2015, 05, 16, 17, 30),
          host_id: coordinator.id}))
    end

    def create_team(params, parent_movement, host)
      team = Movement.where(name: params["name"]).first_or_create!(
        params.merge(parent_id: parent_movement.id))
      team.users << host unless team.users.include? host
      return team
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

    approved_event = movement.events.where(name: "FOTC info session").first_or_create!(
        name: "FOTC info session",
        address: "700 W Van Buren",
        city: "Chicago",
        zip: "60634",
        state: "IL",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 2,
        approved: true,
        notes: "Thanks for attending! We will all be wearing red to this event, to show our solidarity.",
        description: "We will be discussing who Friends of the Congo are, and how you can be involved.",
        host_id: non_coordinator.id)

    unapproved_event = movement.events.where(name: "Screening Cats, the Musical").first_or_create!(
        name: "Screening Cats, the Musical",
        address: "700 W Van Buren",
        city: "Chicago",
        zip: "60634",
        state: "IL",
        start_time: DateTime.new(2015, 05, 14, 15, 30),
        end_time: DateTime.new(2015, 05, 14, 17, 30),
        event_type_id: 3,
        approved: false,
        notes: "Thanks for attending! We will all be wearing red to this event, to show our solidarity.",
        description:  "Just like the title says, we will LITERALLY be screening CATS, THE MUSICAL",
        host_id: non_coordinator.id)


    submovement_owner = User.where(email: "subowner@example.com").first_or_create!(name: "subowner",
                                   email: "subowner@example.com",
                                   password: "password",
                                   password_confirmation: "password")


    team1 = create_team(fotc_teams.first, movement, coordinator)
    team2 = create_team(fotc_teams.second, movement, submovement_owner)


    fotc_teams.each do |team|
      create_team(team, movement, submovement_owner)
    end

    create_event(team_events[0], team1, coordinator, 5)
    create_event(team_events[1], team2, coordinator, 5)
 end

end

