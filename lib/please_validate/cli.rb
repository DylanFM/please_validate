module PleaseValidate
  class Cli
    class << self
      def execute(args)
        new(args)
      end
    end
    
    def initialize(args)
      @file = args[0]
      @result = validate
      display
    end
    
    def validate
      PleaseValidate::Validator.file(@file)
    end
    
    def display
      puts "#{@result[:status].to_s.capitalize}: #{@file}"
      if @result[:status] == :invalid
        puts "#{@result[:error_count]} error#{@result[:error_count] == 1 ? nil:'s'}:"
        @result[:errors].each do |error|
          puts "Line #{error[:line]}, Column #{error[:col]}: #{error[:message]}"
        end
      end
    end
  end
end