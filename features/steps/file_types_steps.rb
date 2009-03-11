Given /^there is an HTML file$/ do
  Given "there is a valid XHTML file"
end

When /^the HTML file is validated$/ do
  When "the file is validated"
end

Then /^there should be no errors$/ do
  @result.should be_an_instance_of(Hash)
end

Given /^there is a non\-HTML file$/ do
  @file = 'cucumber.yml'
  File.exist?(@file).should be_true
end

When /^the non\-HTML file is requested$/ do
  #Nothing to go here?
end

Then /^there should be an error$/ do
  lambda { PleaseValidate::Validator.file(@file) }.should raise_error
end