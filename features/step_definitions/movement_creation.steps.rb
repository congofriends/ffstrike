create_new_movement_page = CreateNewMovementPage.new
movement_dashboard_page = MovementDashboardPage.new
home_page = HomePage.new

Given(/^a user account exists/) do
  @user = FactoryGirl.create(:user, email: "leah@brodsky.com", password: "hitherefolks")
end

Given(/^I am logged in as a Movement Coordinator/) do
  visit new_user_session_path
  home_page.coordinator_log_in()
end

Given(/^I have an existing movement/) do 
  create_new_movement_page.fill_form_and_submit()
end

Given "I am on the dashboard for $n" do |name|
  movement_dashboard_page.visit_movement_dashboard(name)
end

Given(/^I am on the home page/) do
  visit root_path
end

When(/^I try to create a movement/) do
  create_new_movement_page.visit_new_movement_page()
end

When(/^I submit all the information that I can/) do
  create_new_movement_page.fill_form()
end

When(/^I publish the movement/) do
  create_new_movement_page.publish_movement()
end

When(/^I email my attendees for the movement$/) do
  movement_dashboard_page.email_attendees_in_movement()
end

When(/^I invite more coordinators via email$/) do
  movement_dashboard_page.invite_coordinators_by_email()
end

Then(/^I receive a message stating that my email has been sent$/) do
  page.should have_selector ".alert", text: "Sending Emails!"
end

Then(/^A visitor can view my movement/) do
  Capybara.reset_sessions!
  visit movement_path(Movement.last)
  page.should have_text("Cats Move")
end

