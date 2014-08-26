class CreateMovementPage
include Capybara::DSL
	def fill_form_and_submit
		visit "/movements/new"
		fill_in 'movement_name', with: 'Congo Week'
		fill_in 'movement_tagline', with: 'Move yo cat!'
		fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
		click_link_or_button 'create_movement'
	end

	def fill_form
		fill_in 'movement_name', with: 'Cats Move'
		fill_in 'movement_tagline', with: 'Move yo cat!'
		fill_in 'movement_video', with: 'https://www.youtube.com/watch?v=Kdgt1ZHkvnM'
	end

	def visit_new_movement_page
		visit "/movements/new"
	end

	def publish_movement
		click_link_or_button 'create_movement'
	end

	def create_existing_movement(user)
		@movement = FactoryGirl.create(:published_movement, name: "go Dogs")
		ownership = FactoryGirl.create(:ownership, movement: @movement, user: user)
		visit "movements/"+ movement.name.gsub(/ /, '-')
	end
end
