class MovementDashboardPage
include Capybara::DSL

	def visit_group_support_tab
		visit "/my_groups#support"
	  select "#{Movement.last.name}", from: "name_id"
	  click_link_or_button "SHOW"
    return self
  end

  def visit_movement_dashboard user
    click_link "#{user.name}"
    click_link "Manage Teams"
    select "#{Movement.last.name}", from: "name_id"
    click_link_or_button "SHOW"
    return self
  end

	def visit_manage_supporters user
    visit_movement_dashboard user
    click_link_or_button "Manage Supporters"
    return self
  end

  def visit_team_events (user)
    visit_movement_dashboard user
    click_link_or_button "Team Events"
    return self
  end

	def email_attendees_in_movement
		click_link_or_button ('EMAIL ATTENDEES')
    fill_in 'subject', with: 'Great job!'
		fill_in 'message', with: 'Chicago, New York and Tennessee events went great, keep up the good work!!!'
		click_link_or_button ('SEND EMAIL')
    return self
	end

	def email_coordinators_by_email
		click_link_or_button('EMAIL COORDINATORS')
    return self
	end

	def can_create_an_email_to_invite_more_corrdinators
		fill_in 'user_email', with: 'johnjacob@gmail.com'
		click_link_or_button('Send an email')
    return self
	end

	def unapprove_event(event)
		event.update(approved: "false")
    return self
  end

  def set_event_approval_to_false event
    find("input#approve-check#{event.id}").click
  end

end
