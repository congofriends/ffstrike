Feature: Creating a movement as a user

Background:
 Given a user account exists
 Given I am logged in as a Movement Coordinator
@ignore
Scenario: User creates a complete movement
 When I create a movement
 Then I get a confirmation that I created a new movement
 And a visitor can view my movement
