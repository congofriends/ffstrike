Feature: new user attends an event

Background:
	Given a user account exists
	Given I have an existing event

Scenario: An user can register for an event
	When I register for an event
	And I fill out user details
	Then I become a new attendee for the event

Scenario: A user is not attending any events
  When I login as a user
  Then I will see the empty events message in my profile
