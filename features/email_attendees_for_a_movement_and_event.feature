Feature: Coordinator Emails all Attendees for a Movement

Background:
	Given a user account exists
	And I have an existing event
 	And I am logged in as a Movement Coordinator

@ignore @javascript
Scenario: Sending an Email to Attendees in a movement
	When I email my attendees for the movement
	Then I receive a message stating that my email has been sent


