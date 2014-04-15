Feature: Coordinator unapproves an event

Scenario: Coordinator can unapprove an event for their movement
Given a user account exists
And I am logged in as a Movement Coordinator
And I have an existing event
When I unapprove an event
Then the event no longer exists
	 