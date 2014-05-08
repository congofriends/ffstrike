create_events_page = CreateEventsPage.new


Given(/^I have an existing event$/) do
  @event = create_events_page.create_existing_event(@user)
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