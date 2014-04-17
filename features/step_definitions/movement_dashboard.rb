create_events_page = CreateEventsPage.new
movement_dashboard_page = MovementDashboardPage.new

Given "I am on the dashboard for $n" do |name|
  movement_dashboard_page.visit_movement_dashboard(name)
end

When(/^I email my attendees for the movement$/) do
  movement_dashboard_page.visit_movement_dashboard(Movement.last.name)
  movement_dashboard_page.email_attendees_in_movement()
end

When(/^I invite more coordinators via email$/) do
  movement_dashboard_page.visit_movement_dashboard(Movement.last.name)
  movement_dashboard_page.invite_coordinators_by_email()
end

Then(/^I can provide an email and have it sent out$/) do
  movement_dashboard_page.can_create_an_email_to_invite_more_corrdinators()
  # currently asserting that a movement coordinator can send an email the feature to send it is currently broken
end