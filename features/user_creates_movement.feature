Feature: Creating a movement as a user

Background:
  Given a user account exists
  Given I am logged in as a user
  Given I am on the home page

Scenario: User creates a complete movement
  When I try to create a movement
  And I submit all the information that I can 
  And I publish the movement
  Then A visitor can view my movement
