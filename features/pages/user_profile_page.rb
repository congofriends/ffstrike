class UserProfilePage
include Capybara::DSL
	def navigate_to_profile
		visit "/movements/profile"
	end

	def events_attending
		find("#event_tab").click
	end
end