class EventActionsPage
include Capybara::DSL
	def create_new_event
		fill_in 'event_name', with: 'Cats and Dogs'
  		fill_in 'event_address', with: '2373'
  		fill_in 'event_city', with: 'Chicago'
  		fill_in 'event_zip', with: '60649'
  		click_link_or_button('create_movement')
	end

	def create_existing_event(user)
		movement = FactoryGirl.create(:published_movement, name: "go Dogs")
  		ownership = FactoryGirl.create(:ownership, movement: movement, user: user)
  		event = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: movement, name: "Crazy Event")	
	end

	def existing_event_with_attendees(user)
		movement = Movement.last
  		ownership = FactoryGirl.create(:ownership, movement: movement, user: user)
  		event = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: movement, name: "Crazy Event")
	  	attendee = FactoryGirl.create(:attendee, movement: movement, event: event)
	end

	def unapprove_an_event(user)
		movement = FactoryGirl.create(:published_movement, name: "go Dogs")
  		event = FactoryGirl.create(:event, host: user, zip: '60649', movement: movement, name: "Crazy Event", approved: "false")
	end

	def select_rally
		click_link_or_button('rally')	
	end

end