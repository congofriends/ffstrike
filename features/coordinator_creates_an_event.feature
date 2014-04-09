Feature: Creating an event as a Coordinator 

Background:
	Given a user account exists

Scenario: Creating an Event as a Coordinator
 	
	Given I am logged in as a Movement Coordinator
  	And I have an existing movement
 	When I create an event
 	Then I can see the confirmation page for the event I created




