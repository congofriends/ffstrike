event_show_page = EventShowPage.new
movement_show_page = MovementShowPage.new

When(/^I register for an event$/) do
	event_show_page.navigate_to(Event.last.name)
	event_show_page.attend_event
end

When(/^I select the Yes! I want to attend button$/) do
	movement_show_page.attend_event
end

When(/^create an attendee account$/) do
	event_show_page.fill_out_attendee_details
end

Then(/^I become a new an attendee for the event$/) do
	page.should have_text("Thanks for signing up!")
end	
