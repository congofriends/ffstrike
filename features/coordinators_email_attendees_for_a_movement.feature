Feature: Coordinator Emails all Attendees for a Movement

Background:
 Given a user account exists
 Given I am logged in as a Movement Coordinator
 Given I have an existing movement
 Given I have an existing event for the movement with attendees
 Given I am on the dashboard for Peta in Chicago

Scenario: Sending an Email to Attendees
When I email my attendees for the movement
Then I receive a message stating that my email has been sent

Scenario: Sending an Email to Invite more Coordinators
When I invite more coordinators via email
Then I can provide an email and have it sent out