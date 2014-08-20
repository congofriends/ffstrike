event_show_page = EventShowPage.new
movement_show_page = MovementShowPage.new
user_profile_page = UserProfilePage.new
home_page = HomePage.new

When(/^I register for an event$/) do
	event_show_page.navigate_to(Event.last.name)
	event_show_page.attend_event
end

When(/^I select the Yes! I want to attend button$/) do
	movement_show_page.attend_event
end

When(/^I fill out user details$/) do
	event_show_page.fill_out_attendee_details
end

When(/^I login as a user$/) do
  visit new_user_session_path({locale: "en"})
  home_page.coordinator_login()
end

When(/^I navigate to my events tab$/) do
  user_profile_page.navigate_to_profile
  user_profile_page.events_attending
end

And(/^I sign up for a task$/) do
  find('input#event_assigned').click
  click_link_or_button('DONE')
end

Then(/^I become a new attendee for the event$/) do
	page.should have_text(Event.last.name)
  find("#event_assigned").checked?
end

Then(/^I will see the empty events message in my profile$/) do
	page.should have_text("You are currently not attending any events")
end
