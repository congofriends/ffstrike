Feature: Searching for movements by valid zipcode on the homepage and movement page

Scenario: Searching with a valid zipcode
Given I am on the home page
And a user account exists
And I have an existing event
When I enter a valid zipcode to search
Then I see movements within the zipcode given

Scenario: Searching with an invalid zipcode
Given I am on the home page
When I search for a movement with an invalid zipcode
Then I see an error message to provide a valid zipcode with only digits

Scenario: Searching with no zipcode
Given I am on the home page
When I search for a movement with no zipcode
Then I see an error message to provide a valid zipcode
