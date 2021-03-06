event_show_page = EventShowPage.new
event_dashboard_page = EventDashboardPage.new
movement_show_page = MovementShowPage.new


When(/^I edit my event$/)do
  event_dashboard_page.navigate_to_event_dash()
  event_dashboard_page.edit_event()
end

When(/^I delete the event$/) do
  event_show_page.delete_event(@user)
end

Then "the event no longer exists" do
  visit splash_path
  event_dashboard_page.event_should_not_exist()
  page.should_not have_content(Event.last.name)
end

Then(/^I am taken to my event page$/) do
  page.should have_text(Event.last.name)
end

Then(/^I am able to see my changes for the event$/) do
  expect(Event.last.reload.address).to eq("123 this street")
end
