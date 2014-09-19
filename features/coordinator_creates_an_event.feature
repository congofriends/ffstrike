Feature: Creating an event as a Coordinator

Background:
	Given a user account exists
	And Congo Week Exists
    And I am the Coordinator of Congo Week
	And I am on the home page
	And I am logged in as a Movement Coordinator

Scenario: Creating an Event as a Coordinator
	When I select the Create Event button
	And I create an event
	Then I can see the confirmation flash message for the event I created

Scenario: Creating an Event as a Coordinator without Event Details
	When I select the Create Event button
	And I create events with time TBD field checked
	Then I can see that the time fields contain TBD

Scenario: Creating a Fundraising Event as a Coordinator
    When I select the Create Event button
    And I select a fundraising event
    Then I can see the fundraising agreement
    And I click next
    Then I can see the confirmation flash message

Scenario: Viewing an Event on Index after Creating an Event
    When I select the Create Event button
    And I create an event
    Then I can see the event on the Events Index

@ignore @javascript
Scenario: An event should not be viewable on index if approval is set to false
    When I select the Create Event button
    And I create an event
    And I set event approval to false
    Then I can not see the event on the event index page

