movement_show_page = MovementShowPage.new

And(/^I visit the team page/) do
  movement_show_page.visit_movement_show_page(Movement.last.name)
end

Then(/^I will be able to join a team/) do
  movement_show_page.join_team
  page.should have_text("Thank you! You have joined #{Movement.last.name}.")
end