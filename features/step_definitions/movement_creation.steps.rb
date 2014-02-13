#require "spec_helper"

Given(/^a user account exists/) do
  user = FactoryGirl.create(:user, email: "leah@brodsky.com", password: "hitherefolks")
end

Given(/^I am logged in as a user/) do
  visit new_user_session_path
  fill_in 'user_email', with: 'leah@brodsky.com'
  fill_in 'user_password', with: 'hitherefolks'
  click_link_or_button 'signin-button'
end

Given(/^I am on the home page/) do
  visit root_path
end

When(/^I try to create a movement/) do
  click_link_or_button 'create-movement-link'
end

And(/^I submit all the information that I can/) do
  fill_in 'movement_name', with: 'Cats Move'
  fill_in 'movement_tagline', with: 'Move yo cat!'
  fill_in 'movement_call_to_action', with: 'Call yo cat'
  fill_in 'movement_extended_description', with: 'extend yo cat'
  fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
end

And(/^I publish the movement/) do
  click_link_or_button 'create_movement'
end

Then(/^A visitor can view my movement/) do
  Capybara.reset_sessions!
  visit visitor_path(Movement.last)
  page.should have_text("Cats Move")
end
