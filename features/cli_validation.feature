Feature: Validate a file
  In order to product valid markup
  As a web developer
  I want to validate a file
  
  Scenario: Validate a file
    Given there is a valid html file examples/valid.html
    When the file is validated and the output is captured
    Then the result should be displayed saying it's valid