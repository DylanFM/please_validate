Feature: Validate an XHTML file
  In order to produce valid markup
  As a web developer
  I want to validate an XHTML file
  
  Scenario: Validate a file
    Given there is a valid html file examples/valid.html
    When the file is validated and the output is captured
    Then the result should be displayed saying it's valid