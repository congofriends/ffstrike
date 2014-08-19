create_events_page = CreateEventsPage.new
movement_dashboard_page = MovementDashboardPage.new

Given "I am on the dashboard for $n" do |name|
  movement_dashboard_page.visit_group_support_tab
end

When(/^I email my attendees for the movement$/) do
  movement_dashboard_page.visit_group_support_tab
  movement_dashboard_page.email_attendees_in_movement()
end

When(/^I invite more coordinators via email$/) do
  movement_dashboard_page.visit_manage_supporters(@user)
  movement_dashboard_page.email_coordinators_by_email()
  movement_dashboard_page.can_create_an_email_to_invite_more_corrdinators()
end
