Feature: Searching for Event by keyword

Background:
 Given multiple events exist

Scenario: User creates a complete movement
 When I search for an event by name
 Then I see a filtered list
