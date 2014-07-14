Feature: Searching for Event by keyword

Background:
 Given multiple events exist

@ignore @javascript
Scenario: User creates a complete movement
 When I search for an event by zipcode
 Then I see a filtered list
