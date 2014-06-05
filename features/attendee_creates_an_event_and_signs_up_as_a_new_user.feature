Feature: Attendee creates an event and signs up as a new user

Background:
	Given a chapter exists

@ignore
Scenario: Creating an Event as a Attendee
	When I make an event
	Then I see that I have created a new account and new event

