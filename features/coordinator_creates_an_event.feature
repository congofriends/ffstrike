Feature: Creating an event as a Coordinator

Background:
	Given a user account exists
	And I am logged in as a Movement Coordinator
 And I have an existing movement
@ignore
Scenario: Creating an Event as a Coordinator
 When I select the Create Event button
	And I select the type of event
   And I create an event
	Then I can see the confirmation page for the event I created
