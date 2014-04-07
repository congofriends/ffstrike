class MovementDashboardPage
include Capybara::DSL

	def visit_movement_dashboard (name)
		visit "/movements/" + name.gsub(/ /, '-') + "/dashboard"
		# visit dashboard_movement_path(Movement.find_by_name(name))
	end

	def email_attendees_in_movement
		click_link ('Email Your Attendees')
  		fill_in 'message', with: 'Chicago, New York and Tennessee events went great, keep up the good work!!!'
  		click_link_or_button ('Send Email')		
	end

	def invite_coordinators_by_email
		click_link_or_button('Invite More Coordinators')
	end

	def can_create_an_email_to_invite_more_corrdinators
		fill_in 'user_email', with: 'johnjacob@gmail.com'
  		click_link_or_button('Send an invitation')
	end

end
