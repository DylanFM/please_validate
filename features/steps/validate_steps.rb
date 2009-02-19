Given /^there is a valid XHTML file$/ do
  @file = 'examples/valid.html'
  File.exist? @file
end

When /^the file is validated$/ do
  @result = PleaseValidate.file(@file)
end

Then /^the response should not show errors$/ do
  @result.has_key?(:errors).should be_false
end

Then /^the file should be valid$/ do
  @result[:status].should == :valid
end