class CreateEventsPage
include Capybara::DSL
	def create_new_event
		# select "option_name_here", :from => "organizationSelect"
		fill_in 'event_name', with: 'Cats and Dogs'
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
		click_link_or_button'create_movement'
	end

	def create_new_event_as_an_attendee
		fill_in 'event_name', with: 'Cats and Dogs'
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
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
	end

	def existing_event_with_attendees(user)
		@movement = Movement.last
  	ownership = FactoryGirl.create(:ownership, movement: @movement, user: user)
  	@event = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: @movement, name: "Crazy Event")
	  attendee = FactoryGirl.create(:attendee, movement: @movement, event: @event)
	end

	def navigate_to()
		name = Movement.last.name
		visit "/movements/" + name.gsub(/ /, '-')
		return self
	end

	def select_rally
		click_link_or_button('rally')
		return self

	end

	def email_attendees_for_an_event ()
		name = Event.last.name
		visit "/events/"+ name.gsub(/ /, '-')
		click_link ('Email Event Attendees')
  	fill_in 'message', with: 'Chicago, New York and Tennessee events went great, keep up the good work!!!'
  	click_link_or_button ('Send Email')
	end

end
