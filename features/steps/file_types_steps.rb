Given /^there is an HTML file$/ do
  Given "there is a valid XHTML file"
end

When /^the HTML file is validated$/ do
  When "the file is validated"
end

Then /^there should be no errors$/ do
  @result.should be_instance_of Hash
  @result.should_not =~ /^Validation failed:/
end

Given /^there is a non\-HTML file$/ do
  @file = 'cucumber.yml'
  File.exist?(@file).should be_true
end

When /^the non\-HTML file is requested$/ do
  When "the file is validated"
end

Then /^there should be an error$/ do
  @result.should be_instance_of String
  @result.should == "Validation failed: the specified file must have a content type of text/html"
end