event_show_page = EventShowPage.new
create_events_page = CreateEventsPage.new
movement_show_page = MovementShowPage.new


Given(/^I have an existing event$/) do
  @event = create_events_page.create_existing_event(@user)
end

Given(/^I have an existing event for the movement with attendees$/) do
  create_events_page.existing_event_with_attendees(@user)
end

When(/^I unapprove an event$/) do
  create_events_page.unapprove_event(@event)
end

When(/^I delete the event$/) do 
  event_show_page.delete_event(@user)
end

When(/^I make an event/)do 
  create_events_page.navigate_to()
  create_events_page.select_rally()
  create_events_page.create_new_event_as_an_attendee()
end

When(/^I create an event/)do
  create_events_page.create_new_event()
end

When(/^I select the Rally button/)do
  create_events_page.select_rally()
end

Then "the event no longer exists" do
  visit root_path
  create_events_page.event_should_not_exist()
  page.should_not have_content(@event.name)
end

Then(/^I can see the confirmation page/)do
  page.should have_text("successfully created a Rally")
end

Then(/^I am taken to my event page$/) do
  page.should have_text(Event.last.name)
end
