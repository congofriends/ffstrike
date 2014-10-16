home_page = HomePage.new

When(/^I search for an event from the home page$/) do
  visit splash_path
  home_page.search_by_valid_zipcode()
end

When(/^I search for a movement with an invalid zipcode$/) do
  visit splash_path
  home_page.search_by_invalid_zipcode()
end

When(/^I search for a movement with no zipcode$/) do
	visit splash_path
  home_page.search_with_no_zipcode()
end

When(/^I select the sign up link$/) do
    visit new_user_session_path({locale: "en"})
    home_page.sign_in()
  	home_page.sign_up()
end

When(/^provide my new login credentials$/) do
  	home_page.fill_in_sign_up_form()
end

Then(/^I see events within the zipcode given$/) do
  page.has_selector? 'movement_name'
end

Then(/^I see an error message to provide a valid zipcode with only digits$/) do
  page.has_selector? 'zip_error'
end

Then(/^I see an error message to provide a valid zipcode$/) do
  page.has_selector? 'zip_error'
end

Then(/^I can see that I have created a new account$/) do
  attendee = User.last.name.upcase
  page.should have_content(attendee)
end

Then(/^I see that I have created a new account and new event$/) do
  attendee = User.last.name
  new_event = Event.last.name
  page.should have_content(attendee.upcase)
  page.should have_content(new_event)
end
