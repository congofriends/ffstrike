Feature: Creating an event as a Coordinator

Background:
	Given a user account exists
	And Congo Week Exists
	And I am on the home page
	And I am logged in as a Movement Coordinator
	And I have an existing movement

Scenario: Creating an Event as a Coordinator
	When I select the Create Event button
	And I create an event
	Then I can see the confirmation page for the event I created

Scenario: Creating an Event as a Coordinator without Event Details
	When I select the Create Event button
	And I create events with time TBD field checked
	Then I can see that the time fields contain TBD
