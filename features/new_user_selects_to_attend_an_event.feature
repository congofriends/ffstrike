Feature: new user attends an event

Background:
  Given a user account exists
  Given I have an existing event

Scenario: A user can register for an event
  When I register for an event
  And I fill out user details
  And I sign up for a task
  And I navigate to my events tab
  Then I become a new attendee for the event

Scenario: A user is not attending any events
  When I login as a user
  And I navigate to my events tab
  Then I will see the empty events message in my profile
