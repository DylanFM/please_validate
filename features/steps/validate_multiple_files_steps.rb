Given /^there are 2 files for validation$/ do
  @files = ['examples/valid.html','examples/invalid.html']
  @files.each do |file|
    File.exist?(file).should be_true
  end
end

When /^they are both requested for validation$/ do
  @results = PleaseValidate::Validator.files(@files)
end

Then /^the result address both files$/ do
  @results.should be_a_kind_of Array
  @results.should have(2).things
  @files.each do |file|
    @results.any? { |r| r[:file] == file }.should be_true
  end
end