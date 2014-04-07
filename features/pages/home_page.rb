class HomePage
include Capybara::DSL
	
	def coordinator_log_in
		fill_in 'user_email', with: 'leah@brodsky.com'
  		fill_in 'user_password', with: 'hitherefolks'
  		click_link_or_button 'signin-button'		
	end

	def search_by_valid_zipcode
		fill_in 'zip', with: '60649'
  		click_link_or_button 'search_zip'
	end

	def search_by_invalid_zipcode
		fill_in 'zip', with: 'asdff'
  		click_link_or_button 'search_zip'
	end

	def search_with_no_zipcode
		fill_in 'zip', with: ''
  		click_link_or_button 'search_zip'
	end
end