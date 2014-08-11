Feature: Signing up as a movement coordinator for the application using their email

Background:
	Given a team exists
	And Congo Week Exists
	And I am on the home page

Scenario: Signing up as a coordinator with my email address
	When I select the sign up link
	And provide my new login credentials
	Then I can see that I have created a new account
