Feature: Coordinator unapproves an event

Scenario: Coordinator can unapprove an event for their movement
Given a user account exists
When I unapprove an event
Then the event, Crazy Event, no longer exists
