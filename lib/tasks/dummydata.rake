task add_dummy_data: :environment do
  puts "adding dummy data..."
    user = User.create(email: "coordinator@example.com", password: "password") 
    movement = Movement.create(name: "Cats", category: "animals", story: "I had a cat once")
    user.update_attributes(movement_id: movement.id)    
    rally = Rally.create(name: "Chicago Rally", address: "123 Chicago St", city: "Chicago", zip: "60647", coordinator_id: user.id, coordinator: user, movement_id: movement.id)
    attendee = Attendee.create(email: "attendee@example.com", movement_id: movement.id, rally_id: rally.id, name: "McAttends")
  puts "dummy data added!"
end

