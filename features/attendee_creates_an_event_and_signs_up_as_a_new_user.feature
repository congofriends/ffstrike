Feature: Attendee creates an event and signs up as a new user

Background:
	Given a chapter exists

Scenario: Creating an Event as a Attendee
	When I make an event
	Then I see that I have created a new account and new event

Scenario: Creating an Event as an Attendee without Location Details
	When I make an unauthenticated event with location TBD field checked
	Then the location fields in the edit event page are empty
	Then the when field on the event page is TBD
