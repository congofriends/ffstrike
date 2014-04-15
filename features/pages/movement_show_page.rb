class MovementShowPage
include Capybara::DSL

	def create_movement(name)
		FactoryGirl.create(:published_movement, name: "go Dogs")
		# Capybara.reset_sessions!
  		# visit movement_path(Movement.last)
	end
	
	def visit_movement_show_page (name)
		visit "/movements/" + name.gsub(/ /, '-')
	end

	def attend_event
		click_link_or_button ('Yes! I want to attend')
	end

end