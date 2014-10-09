create_events_page = CreateEventsPage.new
events_index_page = EventsIndexPage.new
movement_dashboard_page = MovementDashboardPage.new


Given(/^I have an existing event$/) do
	create_events_page.create_existing_event(@user)
end

Given(/^I have an existing event for the movement with attendees$/) do
	create_events_page.existing_event_with_attendees(@user)
end

When(/^I make an event/)do
	create_events_page.select_create_event.create_new_event_as_an_attendee()
end

When(/^I create an event/)do
	create_events_page.create_new_event()
end

When(/^I select a fundraising event/)do
  create_events_page.select_fundraising_event()
end

When(/^I select the Create Event button/)do
	create_events_page.select_create_event()
end

Then(/^I can see the fundraising agreement/)do
  page.should have_text("Authorization to Operate an Event for the Benefit of The Friends of the Congo")
end

And(/^I click next/)do
  create_events_page.click_next()
end

Then(/^I can see the confirmation flash message/)do
  page.should have_text("successfully created an event!")
end

And(/^I select the type of event$/) do
	create_events_page.select_event_type()
end

When(/^I create events with time TBD field checked/) do
	create_events_page.create_new_event_without_time()
end

Then(/^I can see that the time fields contain TBD/) do
	find_field('event_start_time').value.should eq 'TBD'
	find_field('event_end_time').value.should eq 'TBD'
end

When(/^I make an unauthenticated event with location TBD field checked/) do
	create_events_page.select_create_event.create_new_event_as_an_attendee_without_location()
end

Then(/^the location fields in the edit event page are empty/) do
	find_field('event_address').value.should eq ''
	find_field('event_address2').value.should eq ''
	find_field('event_zip').value.should eq ''
end

Then(/^I can see the event on the Events Index/) do
  events_index_page.navigate_to
  page.should have_content(Event.last.name)
end

When(/^I set event approval to false/) do
  movement_dashboard_page.visit_team_events @user
  movement_dashboard_page.set_event_approval_to_false Event.last
end

Then(/^I can not see the event on the event index page/) do
  events_index_page.navigate_to
  page.should_not have_content(Event.last.name)
end
