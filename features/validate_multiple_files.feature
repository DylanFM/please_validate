Feature: Validates multiple files
  In order to develop efficiently
  As a developer
  I want to validate multiple files at once

	Scenario: validate 2 files
	  Given there are 2 files for validation
	  When they are both requested for validation
	  Then the result should address both files
	
	Scenario: validate 2 files through cli
	  Given there are 2 files for validation
	  When they are both requested for validation via cli
	  Then the result should mention both files
	
