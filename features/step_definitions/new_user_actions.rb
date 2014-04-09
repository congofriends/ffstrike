home_page = HomePage.new

Given(/^I am on the login page$/) do
  visit new_user_session_path
  home_page.sign_in()
end

When(/^I enter a valid zipcode to search$/) do
  home_page.search_by_valid_zipcode()
end

When(/^I search for a movement with an invalid zipcode$/) do
  home_page.search_by_invalid_zipcode()
end

When(/^I search for a movement with no zipcode$/) do
	home_page.search_with_no_zipcode()
end

When(/^I select the sign up link$/) do
  	home_page.sign_up()
end

When(/^provide my new login credentials$/) do
  	home_page.fill_in_sign_up_form()
end		

Then(/^I see movements within the zipcode given$/) do
  page.has_selector? 'movement_name'
end

Then(/^I see an error message to provide a valid zipcode with only digits$/) do
  page.has_selector? 'zip_error'
end

Then(/^I see an error message to provide a valid zipcode$/) do
  page.has_selector? 'zip_error'
end



Then(/^I can see that I have created a new account$/) do
  page.should have_content('Welcome! You have signed up successfully.')
end