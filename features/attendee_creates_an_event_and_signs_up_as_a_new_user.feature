Feature: Attendee creates an event and signs up as a new user

Background:
 	Given I am an attendee
 	And a user account exists
 	And I have an existing event

Scenario: Creating an Event as a Attendee
 	When I make an event
 	Then I see that I have created a new account and new event
