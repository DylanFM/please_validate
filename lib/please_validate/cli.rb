require 'optparse'
require 'colored'

module PleaseValidate
  class CLI
    class << self
      # Execute the CLI
      def execute(stdout, arguments=[])
        options = {}
        mandatory_options = %w(  )

        parser = OptionParser.new do |opts|
          opts.banner = <<-BANNER.gsub(/^          /,'')
            Please Validate does some lovely markup validation of your (X)HTML files.

            Usage: #{File.basename($0)} /path/to/file [options]

            Options are:
          BANNER
          opts.separator ""
          # opts.on("-p", "--path=PATH", String,
          #                   "This is a sample message.",
          #                   "For multiple lines, add more strings.",
          #                   "Default: ~") { |arg| options[:path] = arg }
          opts.on("-h", "--help",
                  "Show this help message.") { stdout.puts opts; exit }
          opts.parse!(arguments)

          if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
            stdout.puts opts; exit
          end
        end
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