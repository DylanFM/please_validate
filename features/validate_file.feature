Feature: Validate a file
  In order to product valid markup
  As a web developer
  I want to validate a file
  
  Scenario: Validate a file
    Given there is an html file
    When I validate the file from the command line
    Then the result should be displayed in the terminal
  

  
