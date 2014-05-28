movement_dashboard_page = MovementDashboardPage.new

When(/^I unapprove an event$/) do
	movement_dashboard_page.unapprove_event(Event.last)
end