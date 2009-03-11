Feature: only HTML files are valid
  In order to validate HTML files
  As a developer
  I want to make sure only HTML files are validated
  
  Scenario: HTML file requessted
    Given there is an HTML file
    When the HTML file is validated
    Then there should be no errors
    
  Scenario: Bad file requested
    Given there is a non-HTML file
    When the non-HTML file is requested
    Then there should be an error
  
  
