Feature: Coordinator unapproves an event

Background:
	Given a user account exists
	And I am logged in as a Movement Coordinator
	And I have an existing event


Scenario: Coordinator can unapprove an event for their movement
	When I unapprove an event
	Then the event no longer exists
	 