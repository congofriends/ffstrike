create_events_page = CreateEventsPage.new


Given(/^I have an existing event$/) do
	create_events_page.create_existing_event(@user)
end

Given(/^I have an existing event for the movement with attendees$/) do
	create_events_page.existing_event_with_attendees(@user)
end

When(/^I make an event/)do
	create_events_page.navigate_to.select_create_event.create_new_event_as_an_attendee()
end

When(/^I create an event/)do
	create_events_page.create_new_event()
end

When(/^I select the Create Event button/)do
	create_events_page.select_create_event()
end

Then(/^I can see the confirmation page/)do
	page.should have_text("successfully created a Rally")
end


And(/^I select the type of event$/) do
	create_events_page.select_event_type()
end

When(/^I create events with time TBD field checked/) do
	create_events_page.create_new_event_without_time()
end

Then(/^I can see that the time fields contain TBD/) do
	click_link_or_button('Go right to your event dashboard.')
	find_field('event_start_time').value.should eq 'TBD'
	find_field('event_end_time').value.should eq 'TBD'
end

When(/^I make an unauthenticated event with location TBD field checked/) do
	create_events_page.navigate_to.select_create_event.create_new_event_as_an_attendee_without_location()
end

Then(/^the location fields in the edit event page are empty/) do
	click_link_or_button('Go right to your event dashboard.')
	find_field('event_address').value.should eq ''
	find_field('event_address2').value.should eq ''
	find_field('event_city').value.should eq ''
	find_field('event_state').value.should eq ''
	find_field('event_zip').value.should eq ''
end

Then(/^the when field on the event page is TBD/) do
	click_link_or_button(Event.last.name)
	page.should have_text('TBD')
end