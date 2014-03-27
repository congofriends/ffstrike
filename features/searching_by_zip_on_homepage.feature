Feature: Searching for movements by valid zipcode on the homepage

Scenario: Searching with a valid zipcode
Given I am on the home page
When I search for an movement with a valid zipcode
Then I see movements within the zipcode given

Scenario: Searching with an invalid zipcode
Given I am on the home page
When I search for a movement with an invalid zipcode
Then I see an error message to provide a valid zipcode with only digits

Scenario: Searching with no zipcode
Given I am on the home page
When I search for a movement with no zipcode
Then I see an error message to provide a valid zipcode
