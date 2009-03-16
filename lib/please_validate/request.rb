module PleaseValidate
  
  class Request
    
    # Takes an array of requested items and passes them to the validator
    def initialize(arguments)
      @files = build_file_list_from_request arguments
      @result = PleaseValidate::Validator.files(files)
    end
    
    # Returns the validation result
    def result
      @result
    end
    
    # Returns all files included in the validation request
    def files
      @files
    end
    
    private
    # Takes the request's arguments and checks if the requested items are directories
    # The result of this method is an array of all arguments (files) that are within this request
    # Any directories will be scanned recursively
    def build_file_list_from_request(arguments)
      files = []
      arguments.each do |item|
        if File.directory? item
          Find.find(item) { |f| files << f if File.file? f }
        else  
          files << item
        end
      end
      files
    end
    
  end
  
end