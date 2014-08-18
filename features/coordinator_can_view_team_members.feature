Feature: Coordinator can view team members on Manage Supporters tab

Background:
  Given a user account exists
  And Congo Week Exists
  And I am logged in as a Movement Coordinator
  And a team exists with members

Scenario: Viewing Team Members on Manage Supporters Tab
  When I am on the dashboard for FOTC Atlanta
  Then I can see the table of team members


