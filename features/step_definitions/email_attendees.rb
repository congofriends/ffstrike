create_events_page = CreateEventsPage.new
movement_dashboard_page = MovementDashboardPage.new

When(/^I email my attendees for the event/)do
  create_events_page.email_attendees_for_an_event()
end

When(/^I invite more coordinators via email$/) do
  movement_dashboard_page.visit_movement_dashboard(Movement.last.name)
  movement_dashboard_page.invite_coordinators_by_email()
end