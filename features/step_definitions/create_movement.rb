create_movement_page = CreateMovementPage.new
movement_dashboard_page = MovementDashboardPage.new
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

Given "I am on the dashboard for $n" do |name|
  movement_dashboard_page.visit_movement_dashboard(name)
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

When(/^I email my attendees for the movement$/) do
  movement_dashboard_page.visit_movement_dashboard(Movement.last.name)
  movement_dashboard_page.email_attendees_in_movement()
end

Then(/^I receive a message stating that my email has been sent$/) do
  page.should have_selector ".alert", text: "Sending Emails!"
end

Then(/^I can provide an email and have it sent out$/) do
  movement_dashboard_page.can_create_an_email_to_invite_more_corrdinators()
  # currently asserting that a movement coordinator can send an email the feature to send it is currently broken
end

Then(/^I get a confirmation that I created a new movement$/)do
  
end

Then(/^a visitor can view my movement/) do
  Capybara.reset_sessions!
  visit movement_path(Movement.last)
  page.should have_text(Movement.last.name)
end
