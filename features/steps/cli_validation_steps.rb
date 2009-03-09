Given /^there is a valid html file ([~\w\/.]+)$/ do |file|
  @file = file
  File.exist?(@file).should be_true
end

When /^the file is validated and the output is captured$/ do
  PleaseValidate::CLI.execute(@stdout_io = StringIO.new, [@file])
  @stdout_io.rewind
  @stdout = @stdout_io.read
end

Then /^the result should be displayed saying it's valid$/ do
  @stdout.should =~ /Valid: #{@file}/
end