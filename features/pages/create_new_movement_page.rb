class CreateNewMovementPage
include Capybara::DSL
	def fill_form_and_submit
		visit "/movements/new"
  		fill_in 'movement_name', with: 'Peta in Chicago'
  		fill_in 'movement_tagline', with: 'Move yo cat!'
  		fill_in 'movement_call_to_action', with: 'Call yo cat'
  		fill_in 'movement_extended_description', with: 'extend yo cat'
 		fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
  		click_link_or_button 'create_movement'
	end

	def fill_form
		fill_in 'movement_name', with: 'Cats Move'
  		fill_in 'movement_tagline', with: 'Move yo cat!'
  		fill_in 'movement_call_to_action', with: 'Call yo cat'
  		fill_in 'movement_extended_description', with: 'extend yo cat'
  		fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
	end

	def visit_new_movement_page
		visit "/movements/new"
	end

	def publish_movement
		click_link_or_button 'create_movement'
	end
end