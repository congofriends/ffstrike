Feature: Coordinator Emails all Attendees for a Movement

Background:
	Given a user account exists
 	And I am logged in as a Movement Coordinator
 	And I have an existing movement
 	And I have an existing event for the movement with attendees

@ignore
Scenario: Sending an Email to Attendees in a movement
	When I email my attendees for the movement
	Then I receive a message stating that my email has been sent

@ignore
Scenario: Sending an Email to Invite more Coordinators
	When I invite more coordinators via email
	Then I can provide an email and have it sent out
