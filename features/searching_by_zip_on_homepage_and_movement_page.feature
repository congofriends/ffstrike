Feature: Searching for movements by valid zipcode on the homepage and movement page

Background:
Given a user account exists
And I have an existing event
@ignore
Scenario: Searching with a valid zipcode
	When I search for an event from the home page
	Then I see events within the zipcode given
@ignore
Scenario: Searching with an invalid zipcode
	When I search for a movement with an invalid zipcode
	Then I see an error message to provide a valid zipcode with only digits
@ignore
Scenario: Searching with no zipcode
	When I search for a movement with no zipcode
	Then I see an error message to provide a valid zipcode
