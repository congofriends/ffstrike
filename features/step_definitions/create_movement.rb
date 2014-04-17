create_movement_page = CreateMovementPage.new
home_page = HomePage.new

Given(/^I am on the home page/) do
  visit root_path
end

Given(/^a user account exists/) do
  @user = FactoryGirl.create(:user, email: "leah@brodsky.com", password: "hitherefolks")
end

Given(/^I am logged in as a Movement Coordinator/) do
  visit new_user_session_path
  home_page.coordinator_log_in()
end

Given(/^I have an existing movement/) do 
  create_movement_page.fill_form_and_submit()
end

Given(/^there is an existing movement$/) do
  create_movement_page.create_existing_movement(@user)
end

When(/^I create a movement/) do
  create_movement_page.fill_form_and_submit()
end

When(/^I submit all the information that I can/) do
  create_movement_page.fill_form()
end

When(/^I publish the movement/) do
  create_movement_page.publish_movement()
end

Then(/^I receive a message stating that my email has been sent$/) do
  page.should have_selector ".alert", text: "Sending Emails!"
end

Then(/^I get a confirmation that I created a new movement$/)do
  page.should have_content(Movement.last.name)
end

Then(/^a visitor can view my movement/) do
  Capybara.reset_sessions!
  visit movement_path(Movement.last)
  page.should have_text(Movement.last.name)
end

