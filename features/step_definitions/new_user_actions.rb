home_page = HomePage.new
movement_show_page = MovementShowPage.new

Given(/^I am on the login page$/) do
  visit new_user_session_path
  home_page.sign_in()
end

Given(/^I am an attendee$/)do
  visit root_path
  # movement_show_page.create_movement()
end

When(/^I enter a valid zipcode to search$/) do
  home_page.search_by_valid_zipcode()
end

Then(/^I can see that I have created a new account$/) do
  page.should have_content('Welcome! You have signed up successfully.')
end

Then(/^I see that I have created a new account and new event$/) do
  page.should have_content("event details for " + Event.last.name)
  page.should have_content(User.last.name)
end