class HomePage
include Capybara::DSL
	
	def coordinator_log_in
		fill_in 'user_email', with: 'leah@brodsky.com'
  		fill_in 'user_password', with: 'hitherefolks'
  		click_link_or_button 'signin-button'		
	end
end