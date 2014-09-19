movement_show_page = MovementShowPage.new

Given(/^a team exists with members/) do
  @team = FactoryGirl.create(:movement, name: "FOTC Atlanta", parent_id: Movement.first.id)
  FactoryGirl.create(:ownership, movement: @team, user: @user)
  @member = FactoryGirl.create(:user, name:"First Member")
  FactoryGirl.create(:membership, movement: @team, user: @member)
end

And(/^I visit the team page/) do
  movement_show_page.visit_movement_show_page(Movement.last.name)
end

Then(/^I will be able to join a team/) do
	movement_show_page.join_team
  	page.should have_text("Thank you! You have joined #{Movement.last.name}.")
end

Then(/^I can see the table of team members/) do
  page.should have_text("TEAM MEMBERS")
  page.should have_text(Movement.last.name)
end
