Feature: Creating a movement as a user

Background:
	Given a user account exists
	And I have an existing event
 	And I am logged in as a Movement Coordinator

Scenario: User creates a complete movement
 When I create a movement
 Then I get a confirmation that I created a new movement
 And a visitor can view my movement
