Feature: Searching for Event by keyword

Background:
 Given multiple events exist

@ignore
Scenario: User creates a complete movement
 When I search for an event by zipcode
 And I wait for the ajax request to finish
 Then I see a filtered list
