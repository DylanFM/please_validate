Given /^there is a valid XHTML file$/ do
  @file = 'examples/valid.html'
  File.exist? @file
end

When /^the file is validated$/ do
  @result = PleaseValidate.file(@file)
end

Then /^the response should not show errors$/ do
  @result[:error_count].should == 0
  @result[:errors].length.should == 0
end

Then /^the file should be valid$/ do
  @result[:status].should == :valid
end

Given /^there is an invalid XHTML file$/ do
  @file = 'examples/invalid.html'
  File.exist? @file
end

Then /^the file should be invalid$/ do
  @result[:status].should == :invalid
end

Then /^the response should show errors$/ do
  @result[:error_count].should > 0
  @result[:errors].length.should > 0
  @result[:errors].each do |error|
    error[:message].should_not be_empty
    error[:line].should be_an_instance_of(Fixnum)
    error[:col].should be_an_instance_of(Fixnum)
  end
end

