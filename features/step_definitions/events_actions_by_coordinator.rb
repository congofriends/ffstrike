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
  click_link_or_button @user.name 
  click_link_or_button 'Profile'
  click_link_or_button 'event_tab'
  click_link('Crazy Event')
  click_link('Edit Event')
  click_link('Remove event')
end

When(/^I create an event/)do
  fill_in 'event_name', with: 'Cats and Dogs'
  fill_in 'event_address', with: '2373'
  fill_in 'event_city', with: 'Chicago'
  fill_in 'event_zip', with: '60649'
  click_link_or_button('create_movement')
end

When(/^I select the Rally button/)do
  click_link_or_button('rally')
end

When "I unapprove an event, $n" do |name|
  click_link_or_button ('Attendee-Events')
  click_link_or_button('Unapprove')
end

Then "the event, $n, no longer exists" do |name|
  visit root_path
  fill_in 'zip', with: '60649'
  click_link_or_button 'search_zip'
  page.should_not have_content(name)
end
