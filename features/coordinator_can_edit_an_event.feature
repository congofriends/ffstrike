Feature: Coordinator can edit an existing event

Background:
	Given a user account exists
	And I have an existing movement
	And I have an existing event
	And I am logged in as a Movement Coordinator


Scenario: Editing an event on the event dashboard
	When I edit my event
	Then I am able to see my changes for the event
