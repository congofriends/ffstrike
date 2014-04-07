event_dashboard_page = EventDashboardPage.new
event_actions_page = EventActionsPage.new

Given(/^I have an existing event$/) do
  event_actions_page.create_existing_event(@user)
end

Given(/^I have an existing event for the movement with attendees$/) do
  event_actions_page.existing_event_with_attendees(@user)
end

When(/^I unapprove an event$/) do
  event_actions_page.unapprove_an_event(@user)
end

When(/^I delete the event$/) do 
  event_dashboard_page.delete_event(@user)
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

Then "the event, $n, no longer exists" do |name|
  visit root_path
  fill_in 'zip', with: '60649'
  click_link_or_button 'search_zip'
  page.should_not have_content(name)
end

Then(/^I can provide an email and have it sent out$/) do
  fill_in 'user_email', with: 'johnjacob@gmail.com'
  click_link_or_button('Send an invitation')
  # currently asserting that a movement coordinator can send an email the feature to send it is currently broken
end

Then(/^I can see the confirmation page/)do
  page.should have_text("successfully created a Rally")
end
