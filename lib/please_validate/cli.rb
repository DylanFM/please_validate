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
      @files = arguments
      @results = validate
      @msg = display
    end
    
    # Calls the validator class's file method for the requested file
    def validate
      PleaseValidate::Validator.files(@files)
    end
    
    # Displays the file validation's results
    def display
      @results.inject('') do |msg,result|
        if result.is_a? Hash
          msg += "#{result[:status].to_s.capitalize}: #{result[:file]}".send(result[:status] == :valid ? :on_green : :on_red)
          if result[:status] == :invalid
            msg += "\n#{result[:error_count]} error#{result[:error_count] == 1 ? nil:'s'}:"
            result[:errors].each do |error|
              msg += "\nLine #{error[:line]}, Column #{error[:col]}".red + ": #{error[:message]}"
            end
          end
        elsif result.is_a? String
          msg += result
        end
        msg += "\n\n"
        msg
      end
    end
    
    #Displays the message for the command line result
    def msg
      @msg
    end
  end
end