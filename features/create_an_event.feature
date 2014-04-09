Feature: Creating an event as a Coordinator and Attendee with an existing movement 

 Scenario: Creating an Event as a Coordinator
 	Given a user account exists
	Given I am logged in as a Movement Coordinator
  	Given I am on the home page
  	Given I have an existing movement
 	When I select the Rally button
 	And I create an event
 	Then I can see the confirmation page

 Scenario: Creating an Event as a Attendee
 	Given I am on the home page
 	Given there is an existing movement
 	When I select the Rally button
 	And as an attendee I create an event 
 	Then I am taken to my event page


