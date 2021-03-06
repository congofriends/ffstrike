class EventDashboardPage
include Capybara::DSL
include BestInPlace::TestHelpers

	def edit_event
		click_link_or_button "Event Details"
		fill_in("event[address]", with: "123 this street")
		click_link_or_button('UPDATE')
	end

	def event_should_not_exist
		fill_in 'zip', with: '60649'
		click_link_or_button 'search_zip'
	end

	def navigate_to_event_dash
		click_link "#{User.find_by_email('leah@brodsky.com').name.upcase}"
		click_link_or_button "MANAGE EVENTS"
		select Event.last.name, from: "name_id"
		click_link_or_button "SHOW"
	end

	def navigate_to_movement_dash
		name = Event.last.movement.name
		visit "/movements/" + name.gsub(/ /, '-') + "/dashboard#events/"
	end

end
