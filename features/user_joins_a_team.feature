Feature: user joins a team

Background:
    Given a team exists
    Given a user account exists

Scenario: A user can join a team
    When I login as a user
    And I visit the team page
    And I click the join team button
    Then I should see a confirmation for joining the team

Scenario: A new user can join a team
	When I visit the team page
	And I click the join team button
	And I fill out user details
	Then I should see a confirmation for joining the team
