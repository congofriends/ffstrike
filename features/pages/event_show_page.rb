class EventShowPage
include Capybara::DSL


	def delete_event (user)
		click_link_or_button user.name 
 		click_link_or_button 'Profile'
  	click_link_or_button 'event_tab'
  	click_link('Crazy Event')
  	click_link('Edit Event')
  	click_link('Remove event')	
	end

	def navigate_to(name)
		visit "/events/" + name.gsub(/ /, '-') 
	end

	def attend_event
		click_link_or_button 'I want to attend'
	end

	def fill_out_attendee_details
		fill_in 'attendee_name', with: 'Attendee'
  		fill_in 'attendee_phone_number', with: '2373331234'
  		fill_in 'attendee_email', with: 'attendee@example.com'
  		click_link_or_button('Sign me up!')
	end

end
