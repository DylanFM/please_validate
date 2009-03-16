Given /^there is a directory containing 3 files$/ do
  @dir = 'examples'
  File.directory?(@dir).should be_true
end

When /^the directory is included in a request$/ do
  @request = PleaseValidate::Request.new(@dir)
end

Then /^the request should have those 3 files$/ do
  ['valid','invalid','another/fancy'].each do |file|
    @request.files.should include "#{@dir}/#{file}.html"
  end
end