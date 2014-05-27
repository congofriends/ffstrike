Feature: new user attends an event

Background:
	Given a user account exists
	Given I have an existing event
@ignore
Scenario: An user can register for an event
	When I register for an event
	And create an attendee account
	Then I become a new an attendee for the event
