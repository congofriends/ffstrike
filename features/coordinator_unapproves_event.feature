Feature: Coordinator unapproves an event

Background:
	Given a user account exists
	And I have an existing event
	And I am on the home page
	And I am logged in as a Movement Coordinator

Scenario: Coordinator can unapprove an event for their movement
	When I unapprove an event
	Then the event no longer exists

