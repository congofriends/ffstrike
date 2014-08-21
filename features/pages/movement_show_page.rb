class MovementShowPage
include Capybara::DSL

	def create_movement(name)
		FactoryGirl.create(:published_movement, name: "go Dogs")
		# Capybara.reset_sessions!
  		# visit movement_path(Movement.last)
  end

	def visit_movement_show_page (name)
		visit "/movements/" + name.gsub(/ /, '-') + '-' + Movement.last.id.to_s
	end

	def attend_event
		click_link_or_button ('Yes! I want to attend')
  end

  def join_team
    click_link_or_button ('SIGN ME UP')
    click_link_or_button ('Join the Team!')
  end

end
