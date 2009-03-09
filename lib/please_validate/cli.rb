require 'colored'

module PleaseValidate
  class CLI
    class << self
      # Execute the CLI
      def execute(stdout, arguments=[])
        new(arguments)
      end
    end
    
    # Takes the requested file, passes it to validate for validation and displays the result with the display method
    def initialize(arguments)
      begin
        @file = arguments[0]
        @result = validate
        display
      rescue Exception => e
        puts "Validation failed"
      end
    end
    
    # Calls the validator class's file method for the requested file
    def validate
      PleaseValidate::Validator.file(@file)
    end
    
    # Displays the file validation's results
    def display
      puts "#{@result[:status].to_s.capitalize}: #{@file}".send(@result[:status] == :valid ? :on_green : :on_red)
      if @result[:status] == :invalid
        puts "#{@result[:error_count]} error#{@result[:error_count] == 1 ? nil:'s'}:"
        @result[:errors].each do |error|
          puts "Line #{error[:line]}, Column #{error[:col]}".red + ": #{error[:message]}"
        end
      end
    end
  end
end