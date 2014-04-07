event_show_page = EventShowPage.new
event_actions_page = EventActionsPage.new

Given(/^I have an existing event$/) do
  event_actions_page.create_existing_event(@user)
end

Given(/^I have an existing event for the movement with attendees$/) do
  event_actions_page.existing_event_with_attendees(@user)
end

Given "I am on the $n dashboard" do |name|
  event_show_page.navigate_to(name)
end

When(/^I unapprove an event$/) do
  event_actions_page.unapprove_an_event(@user)
end

When(/^I delete the event$/) do 
  event_show_page.delete_event(@user)
end

When(/^as an attendee I create an event/)do
  event_actions_page.create_new_event_as_an_attendee()
end

When(/^I create an event/)do
  event_actions_page.create_new_event()
end

When(/^I select the Rally button/)do
  event_actions_page.select_rally()
end

When "I unapprove an event, $n" do |name|
  click_link_or_button ('Attendee-Events')
  click_link_or_button('Unapprove')
end

When(/^I email my attendees for the event/)do
  event_actions_page.email_attendees_for_an_event()
end

Then "the event, $n, no longer exists" do |name|
  visit root_path
  event_actions_page.event_should_not_exist()
  page.should_not have_content(name)
end

Then(/^I can see the confirmation page/)do
  page.should have_text("successfully created a Rally")
end

Then(/^I am taken to my event page$/) do
  page.should have_text(Event.last.name)
end
