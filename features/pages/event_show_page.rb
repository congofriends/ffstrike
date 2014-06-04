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
		id = "-" + Event.last.id.to_s
		visit "/events/" + name.gsub(/ /, '-') + id
	end

	def attend_event
		click_link_or_button('ATTEND')
	end

	def fill_out_attendee_details
		fill_in 'user_name', with: 'Dan'
		fill_in 'user_phone', with: '2373331234'
		fill_in 'user_email', with: 'dan@gmail.com'
  	click_link_or_button('Sign me up!')
	end

end
