Feature: Coordinator and event host can delete an event 

Background:
Given a user account exists
Given I am logged in as a Movement Coordinator
Given I am on the home page

Scenario: Coordinator can delete an event
Given I have an existing movement
And I have an existing event
When I delete the event
Then the event, Crazy Event, no longer exists

Scenario: Event host can delete an approved event when logged in
Given I have an existing event
When I delete the event 
Then the event, Crazy Event, no longer exists

