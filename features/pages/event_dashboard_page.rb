class EventDashboardPage
include Capybara::DSL
	
	def edit_event
		# new_address = Event.last.address
  		click_link_or_button('Dashboard')
  		click_link_or_button('best_in_place')
  		# need to grab the id of the event to grab the element
  		fill_in 'address', with: '123 this street'
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