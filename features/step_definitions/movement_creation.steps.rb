
Given(/^a user account exists/) do
  @user = FactoryGirl.create(:user, email: "leah@brodsky.com", password: "hitherefolks")
end

Given(/^I am logged in as a user/) do
  visit new_user_session_path
  fill_in 'user_email', with: 'leah@brodsky.com'
  fill_in 'user_password', with: 'hitherefolks'
  click_link_or_button 'signin-button'
end

Given(/^I have an existing movement/) do 
  visit "/movements/new"
  fill_in 'movement_name', with: 'Cats Move'
  fill_in 'movement_tagline', with: 'Move yo cat!'
  fill_in 'movement_call_to_action', with: 'Call yo cat'
  fill_in 'movement_extended_description', with: 'extend yo cat'
  fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
  click_link_or_button 'create_movement'
end

Given "I am on the dashboard for $n" do |name|
  visit dashboard_movement_path(Movement.find_by_name(name))
end


Given(/^I am on the home page/) do
  visit root_path
end

When(/^I try to create a movement/) do
  visit "/movements/new"
end

When(/^I submit all the information that I can/) do
  fill_in 'movement_name', with: 'Cats Move'
  fill_in 'movement_tagline', with: 'Move yo cat!'
  fill_in 'movement_call_to_action', with: 'Call yo cat'
  fill_in 'movement_extended_description', with: 'extend yo cat'
  fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
end

When(/^I publish the movement/) do
  click_link_or_button 'create_movement'
end

Then(/^I can see the confirmation page/)do
  page.should have_text("successfully created a Rally")
end

Then(/^A visitor can view my movement/) do
  Capybara.reset_sessions!
  visit movement_path(Movement.last)
  page.should have_text("Cats MoveMOVE")
end

