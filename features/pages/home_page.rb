class HomePage
include Capybara::DSL

	def coordinator_login
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

	def sign_in
    save_and_open_page
		click_link 'sign-in'
	end

	def sign_up
		click_link_or_button'Sign up'
	end

	def fill_in_sign_up_form
		fill_in 'user_name', with: 'Jessica'
		fill_in 'user_email', with: 'jess@gmail.com'
  	fill_in 'user_password', with: 'abc1234'
  	fill_in 'user_password_confirmation', with: 'abc1234'
  	click_link_or_button 'sign_up_button'
	end
end
