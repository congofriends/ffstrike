class CreateEventsPage
include Capybara::DSL
	
	def create_new_event
	click_link_or_button('MOVIE SCREENING')
	fill_in 'event_name', with: 'Cats and Dogs'
	fill_in 'event_description', with: 'Cats and Dogs are cool'
	fill_in 'event_address', with: '2373'
	fill_in 'event_city', with: 'Chicago'
	fill_in 'event_zip', with: '60649'
	fill_in 'event_state', with: 'IL'
	fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
	fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
    select "United States", from: "event_country", :match => :first
    click_link_or_button "Next"
	find('input#create_event').click
	end
	
	def create_new_event_with_javascript
	click_link_or_button('MOVIE SCREENING')
	fill_in 'event_name', with: 'Cats and Dogs'
	#fill_in 'event_description', with: 'Cats and Dogs are cool'
	find(:css, "div.redactor_form-control.redactor_redactor.redactor_editor").set("Cats and Dogs are awesome")
	fill_in 'event_address', with: '2373'
	fill_in 'event_city', with: 'Chicago'
	fill_in 'event_zip', with: '60649'
	fill_in 'event_state', with: 'IL'
	fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
	fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
    select "United States", from: "event_country", :match => :first
    click_link_or_button "Next"
	find('input#create_event').click
  end

  def select_fundraising_event
	click_link_or_button('FUNDRAISER FOR FOTC')
    fill_in 'event_name', with: 'Cats and Dogs'
    fill_in 'event_description', with: "Cats and Dogs are my faaaaavorite aminals"
    fill_in 'event_address', with: '2373'
    fill_in 'event_city', with: 'Chicago'
    fill_in 'event_zip', with: '60649'
    fill_in 'event_state', with: 'IL'
    fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
    fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
    select "United States", from: "event_country", :match => :first
  end

  def click_next
    click_link_or_button "Next"
    find('input#create_event').click
  end

	def create_new_event_without_time
		click_link_or_button('MOVIE SCREENING')
		fill_in 'event_name', with: 'Event Without Time'
		fill_in 'event_description', with: "I don't know when this event is happening yet"
		fill_in "event_start_time", with: DateTime.new(2015, 05, 17, 15, 30)
		find(:css, "#event_time_tbd").set(true)
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
		fill_in 'event_state', with: 'IL'
    	select "United States", from: "event_country", :match => :first
    	click_link_or_button "Next"
		find('input#create_event').click
	end

	def create_new_event_as_an_attendee
		click_link_or_button('MOVIE SCREENING')
		fill_in 'event_name', with: 'Cats and Dogs'
		fill_in 'event_description', with: 'Cats and Dogs are cool'
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
		fill_in 'event_state', with: 'IL'
    	select "United States", from: "event_country", :match => :first
		fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
		fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
    	click_link_or_button 'Next', :match => :first
		fill_in 'user_name', with: 'Mackenzie'
		fill_in 'user_surname', with: 'Lee'
		fill_in 'user_email', with: 'mack@gmail.com'
		fill_in 'user_password', with: 'movement1234'
		fill_in 'user_password_confirmation', with: 'movement1234'
		click_link_or_button('CREATE EVENT')
		return self
	end

	def create_new_event_as_an_attendee_without_location
		click_link_or_button('MOVIE SCREENING')
		fill_in 'event_name', with: 'Cats and Dogs'
		find(:css, "div.redactor_form-control.redactor_redactor.redactor_editor").set("Cats and Dogs are awesome")
		fill_in 'event_address', with: '2373'
		fill_in 'event_city', with: 'Chicago'
		fill_in 'event_zip', with: '60649'
		fill_in 'event_state', with: 'IL'
		select "United States", from: "event_country", :match => :first
		find(:css, "#event_location_tbd").set(true)
		fill_in "event_start_time", with: DateTime.new(2015, 05, 16, 15, 30)
		fill_in "event_end_time", with: DateTime.new(2015, 05, 17, 15, 30)
		click_link_or_button 'Next', :match => :first
    	click_link_or_button 'Next'
		fill_in 'user_name', with: 'Mackenzie'
		fill_in 'user_surname', with: 'Lee'
		fill_in 'user_email', with: 'mack@gmail.com'
		fill_in 'user_password', with: 'movement1234'
		fill_in 'user_password_confirmation', with: 'movement1234'
		find('input#create_event').click
	end

	def create_existing_event(user)
		movement = FactoryGirl.create(:published_movement, name: "Congo Week")
		ownership = FactoryGirl.create(:ownership, movement: movement, user: user)
		event = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: movement, name: "Crazy Event")
		team = FactoryGirl.create(:published_movement, parent_id: movement.id)
		attendee = FactoryGirl.create(:user)
		attendance = FactoryGirl.create(:attendance, user: attendee, event: event)
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
		name = Movement.first.name
		id = Movement.first.id
		visit "/movements/" + name.gsub(/ /, '-') + '-' + id.to_s
		return self
	end

	def select_create_event
		navigate_to_events
		click_link_or_button('HOST AN EVENT')
		return self
	end

	def navigate_to_events()
		name = Movement.first.name
		id = Movement.first.id
		visit "/movements/" + name.gsub(/ /, '-')  + '-' + id.to_s + "/events/"
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
