Feature: Creating an event as a Coordinator with an existing movement 

Background:
  Given a user account exists
  Given I am logged in as a user
  Given I am on the home page
  Given I have an existing movement

 Scenario: Creating an Event as a Coordinator
 When I select the Rally button
 And I create an event
 Then I can see the confirmation page
