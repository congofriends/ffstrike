class EventDashboardPage
include Capybara::DSL
include BestInPlace::TestHelpers

	def edit_event
		click_link_or_button('Dashboards')
		click_link_or_button(Event.last.movement.name.capitalize)
		click_link_or_button('Events')
		find(".edit-event-dash").click
		event_id = Event.last.id
		# edit_address_id = "#best_in_place_event_" + event_id.to_s + "_address"
		# find(edit_address_id).click
    fill_in("event[address]", with: "123 this street")
		click_link_or_button('Update')
	end

	def event_should_not_exist
		fill_in 'zip', with: '60649'
		click_link_or_button 'search_zip'
	end

	def navigate_to
		name = Event.last.name
		id = "-" + Event.last.id.to_s
		visit "/events/" + name.gsub(/ /, '-') + id + "/dashboard#event/"
	end
end
