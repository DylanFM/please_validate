require 'optparse'
require 'colored'

module PleaseValidate
  class CLI
    class << self
      # Execute the CLI
      def execute(stdout, arguments=[])
        options = { :quiet => false }
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
          opts.on("-q", "--quiet",
                  "Hide invalid file notices.") { options[:quiet] = true }
          opts.on("-h", "--help",
                  "Show this help message.") { stdout.puts opts; exit }
          opts.parse!(arguments)

          if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
            stdout.puts opts; exit
          end
        end
        validation = new(arguments, options)
        stdout.puts validation.msg
      end
    end
    
    # Takes the arguments, passes it to validate for validation and displays the result
    def initialize(arguments, options)
      @result, @options = validate(arguments), options
      @msg = display
    end
    
    # Creates a new request object and returns its result
    def validate(items)
      request = PleaseValidate::Request.new(items)
      request.result
    end
    
    # Displays the request's results
    def display
      @result.inject('') do |msg,result|
        if result.is_a? String
          next msg if options[:quiet] && result =~ /^Validation failed:/
          msg += result
        elsif result.is_a? Hash
          msg += message_for result
        end
        "#{msg}\n\n"
      end
    end
    
    # Displays the message for the command line result
    def msg
      @msg
    end
    
  protected
    # Returns a hash of options passed to command line invocation
    def options
      @options
    end
    
    # Takes one result from the validation and makes a message suitable for output
    def message_for(result)
      msg = "#{result[:status].to_s.capitalize}: #{result[:file]}".send(result[:status] == :valid ? :on_green : :on_red)
      if result[:status] == :invalid
        msg += "\n#{result[:error_count]} error#{result[:error_count] == 1 ? nil:'s'}:"
        result[:errors].each do |error|
          msg += "\nLine #{error[:line]}, Column #{error[:col]}".red + ": #{error[:message]}"
        end
      end
      msg
    end
  end
end