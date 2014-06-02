class CreateEventsPage
include Capybara::DSL
	def create_new_event
		fill_in 'event_name', with: 'Cats and Dogs'
    fill_in 'event_description', with: "Cats and Dogs are my faaaaavorite aminals"
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
		fill_in 'event_state', with: 'IL'
		fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
		fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
		click_link_or_button'Create Event'
	end

	def create_new_event_as_an_attendee
		fill_in 'event_name', with: 'Cats and Dogs'
    fill_in 'event_description', with: 'Arent cats and dogs your faaaaavorite mammals?'
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
		fill_in 'event_state', with: 'IL'
		fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
		fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
		fill_in 'user_name', with: 'Mackenzie'
		fill_in 'user_email', with: 'mack@gmail.com'
		fill_in 'user_password', with: 'movement1234'
		fill_in 'user_password_confirmation', with: 'movement1234'
		click_link_or_button('Create a user and event')
		return self
	end

	def create_existing_event(user)
		movement = FactoryGirl.create(:published_movement, name: "go Dogs")
  	ownership = FactoryGirl.create(:ownership, movement: movement, user: user)
  	event = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: movement, name: "Crazy Event")
		chapter = FactoryGirl.create(:published_movement, parent_id: movement.id)
		return self
	end

	def existing_event_with_attendees(user)
		@movement = Movement.last
  		ownership = FactoryGirl.create(:ownership, movement: @movement, user: user)
  		@event = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: @movement, name: "Crazy Event")
	  	attendee = FactoryGirl.create(:user)
	  	attendance = FactoryGirl.create(:attendance, user: attendee, event: @event)
	end

	def navigate_to()
		name = Movement.last.name
		visit "/movements/" + name.gsub(/ /, '-')
		return self
	end

  def select_create_event
  	navigate_to_events
    click_link_or_button('CREATE AN EVENT')
    return self
  end

  def navigate_to_events()
  	name = Movement.last.name
  	visit "/movements/" + name.gsub(/ /, '-') + "/events/"
  	return self
  end

  def select_event_type
    click_link_or_button('Rally')
    return self
  end

  # def select_rally
  #   click_link_or_button('Rally')
  #   return self
  # end

  def email_attendees_for_an_event ()
    name = Event.last.name
    visit "/events/"+ name.gsub(/ /, '-')
    click_link ('Email Event Attendees')
    fill_in 'message', with: 'Chicago, New York and Tennessee events went great, keep up the good work!!!'
    click_link_or_button ('Send Email')
  end


end
