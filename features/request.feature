Feature: Validation requests are wrapped in a request object
  In order to validate all my contents
  As a request
  I want my request to be understood

	Scenario: Request contains a directory
	  Given there is a directory containing 3 files
	  When the directory is included in a request
	  Then the request should have those 3 files