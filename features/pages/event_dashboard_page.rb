class EventDashboardPage
include Capybara::DSL

	def delete_event (user)
		click_link_or_button user.name 
 		click_link_or_button 'Profile'
  		click_link_or_button 'event_tab'
  		click_link('Crazy Event')
  		click_link('Edit Event')
  		click_link('Remove event')		
	end

end
