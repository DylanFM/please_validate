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
      puts "Validated #{@file}:"
      puts "The file is #{@result[:status]}"
      if @result[:status] == :invalid
        puts "There are #{@result[:errors].length} error#{@result[:errors].length == 1 ? nil:'s'}"
      end
    end
  end
end