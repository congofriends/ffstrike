Feature: user joins a team

Background:
    Given a team exists
    Given a user account exists

Scenario: A user can join a team
    When I login as a user
    And I visit the team page
    Then I will be able to join a team
