class EventDashboardPage
include Capybara::DSL
include BestInPlace::TestHelpers

	def edit_event
    	fill_in("event[address]", with: "123 this street")
		click_link_or_button('Update')
	end

	def event_should_not_exist
		fill_in 'zip', with: '60649'
		click_link_or_button 'search_zip'
	end

	def navigate_to_event_dash
		 binding.pry
		 click_link "#{User.last.name}"
		 click_link "Manage My Events"
		 select "Crazy Event", from: "name_id"
		 click_link_or_button "SHOW"
	end

	def navigate_to_movement_dash
		name = Event.last.movement.name
		visit "/movements/" + name.gsub(/ /, '-') + "/dashboard#events/"
	end

end
