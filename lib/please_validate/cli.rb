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
        validation = new(arguments)
        stdout.puts validation.msg
      end
    end
    
    # Takes the requested file, passes it to validate for validation and displays the result with the display method
    def initialize(arguments)
      begin
        @file = arguments[0]
        @result = validate
        @msg = display
      rescue Exception => e
        @msg = e
      end
    end
    
    # Calls the validator class's file method for the requested file
    def validate
      PleaseValidate::Validator.file(@file)
    end
    
    # Displays the file validation's results
    def display
      msg = "#{@result[:status].to_s.capitalize}: #{@file}".send(@result[:status] == :valid ? :on_green : :on_red)
      if @result[:status] == :invalid
        msg += "\n#{@result[:error_count]} error#{@result[:error_count] == 1 ? nil:'s'}:"
        @result[:errors].each do |error|
          msg += "\nLine #{error[:line]}, Column #{error[:col]}".red + ": #{error[:message]}"
        end
      end
      msg
    end
    
    #Displays the message for the command line result
    def msg
      @msg
    end
  end
end