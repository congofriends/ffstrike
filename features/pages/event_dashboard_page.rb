class EventDashboardPage
include Capybara::DSL
include BestInPlace::TestHelpers
	
	def edit_event
		# new_address = Event.last.address
  		click_link_or_button('Dashboard')
  		# need to grab the id of the event to grab the element
  		fill_in 'address', with: '123 this street'
		event_id = Event.last.id
		edit_address_id = "span#best_in_place_event_" + event_id.to_s + "_address"
		click_link_or_button('Dashboard')
  		within(:css, edit_address_id) do
	  		fill_in(edit_address_id, with: '123 this street')
    	end
  		click_link_or_button('Update')
	end

	def event_should_not_exist
  		fill_in 'zip', with: '60649'
  		click_link_or_button 'search_zip'
	end

	def navigate_to
		name = Event.last.name
		visit "/events/" + name.gsub(/ /, '-') +"/dashboard#event/"
	end

end
