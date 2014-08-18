class MovementDashboardPage
include Capybara::DSL

	def visit_group_support_tab
		visit "/my_groups#support"
	  select "#{Movement.last.name}", from: "name_id"
	  click_link_or_button "SHOW"
	end

	def visit_movement_dashboard (user)
		click_link "#{user.name}"
	  click_link "Manage My Groups"
	  select "#{Movement.last.name}", from: "name_id"
	  click_link_or_button "SHOW"
	  click_link_or_button "Manage Supporters"
	end

	def email_attendees_in_movement
		click_link_or_button ('EMAIL ATTENDEES')
    fill_in 'subject', with: 'Great job!'
		fill_in 'message', with: 'Chicago, New York and Tennessee events went great, keep up the good work!!!'
		click_link_or_button ('SEND EMAIL')
	end

	def email_coordinators_by_email
		click_link_or_button('EMAIL COORDINATORS')
	end

	def can_create_an_email_to_invite_more_corrdinators
		fill_in 'user_email', with: 'johnjacob@gmail.com'
		click_link_or_button('Send an email')
	end

	def unapprove_event(event)
		event.update(approved: "false")
	end

end
