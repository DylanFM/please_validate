Feature: Validate markup
  In order to be standards compliant
  As a web developer
  I want to validate my markup
  
  Scenario: Validate valid markup
    Given there is a valid XHTML file
    When the file is validated
    Then the response should not show errors
    And the file should be valid
  
