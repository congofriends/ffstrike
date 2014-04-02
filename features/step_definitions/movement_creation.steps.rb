
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

Given(/^I have an existing event$/) do
  movement = FactoryGirl.create(:published_movement, name: "go Dogs")
  ownership = FactoryGirl.create(:ownership, movement: movement, user: @user)
  event = FactoryGirl.create(:approved_event, host: @user, zip: '60649', movement: movement, name: "Crazy Event")
end

When(/^I unapprove an event$/) do
  movement = FactoryGirl.create(:published_movement, name: "go Dogs")
  event = FactoryGirl.create(:event, host: @user, zip: '60649', movement: movement, name: "Crazy Event", approved: "false")
end

When(/^I delete the event$/) do
  click_link_or_button 'stuff'
  click_link_or_button 'event_tab'
  click_link('Crazy Event')
  click_link('Edit Event')
  click_link('Remove event')
end

When(/^I select the Rally button/)do
  click_link_or_button('rally')
end

When(/^I create an event/)do
  fill_in 'event_name', with: 'Cats and Dogs'
  fill_in 'event_address', with: '2373'
  fill_in 'event_city', with: 'Chicago'
  fill_in 'event_zip', with: '60649'
  click_link_or_button('create_movement')
end

When "I unapprove an event, $n" do |name|
  click_link_or_button ('Attendee-Events')
  click_link_or_button('Unapprove')
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

When(/^I enter a valid zipcode to search$/) do
  fill_in 'zip', with: '60649'
  click_link_or_button 'search_zip'
end

When(/^I search for a movement with an invalid zipcode$/) do
  fill_in 'zip', with: 'asdff'
  click_link_or_button 'search_zip'
end

When(/^I search for a movement with no zipcode$/) do
  fill_in 'zip', with: ''
  click_link_or_button 'search_zip'
end

Then(/^I can see the confirmation page/)do
  page.should have_text("successfully created a Rally")
end

Then(/^A visitor can view my movement/) do
  Capybara.reset_sessions!
  visit movement_path(Movement.last)
  page.should have_text("Cats Move")
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

Then "the event, $n, no longer exists" do |name|
  visit root_path
  fill_in 'zip', with: '60649'
  click_link_or_button 'search_zip'
  page.should_not have_content(name)
end
