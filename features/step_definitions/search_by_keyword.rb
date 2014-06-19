Given(/^multiple events exist$/) do
  user = FactoryGirl.create(:user, email: "user@test.com", password: "hitherefolks")
	@movement = FactoryGirl.create(:published_movement, name: "go Dogs")
  ownership = FactoryGirl.create(:ownership, movement: @movement, user: user)
  @event1 = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: @movement, name: "Crazy Event")
  @event2 = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: @movement, name: "Sad Event")
  @event3 = FactoryGirl.create(:approved_event, host: user, zip: '60649', movement: @movement, name: "Happy Event")
  @event4 = FactoryGirl.create(:approved_event, host: user, zip: '10029', movement: @movement, name: "Movie Screening")
end

When(/^I search for an event by zipcode$/) do
	visit movement_events_path(@movement)
	fill_in 'query', with: '60649'
  find('input.query-btn').click
end

When(/^I wait for the ajax request to finish$/) do
end

Then(/^I see a filtered list$/) do
  page.should have_content(@event1.name)
	page.should_not have_content(@event4.name)
end
