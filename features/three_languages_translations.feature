Feature: Verify translation to EN/ES/FR are working 

Background:
Given a user account exists
And I have an existing event

  Scenario: English is default language
    When user visits the home page 
    Then default language is English

  Scenario: Spanish translation
    When user visits the home page
    And user switches to spanish language
    Then home page content shows in Spanish 

  Scenario: French translation
    When user visits the home page
    And user switches to french language
    Then home page content shows in French

