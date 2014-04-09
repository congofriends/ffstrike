Feature: Attendee creates an event and signs up as a new user

Scenario: Creating an Event as a Attendee

 	Given I am an attendee
 	When I view a existing movement 
 	And I create an event 
 	Then I see that I have created a new account and new event