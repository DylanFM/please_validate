module PleaseValidate
  class Cli
    class << self
      def execute(args)
        new(args)
      end
    end
    
    def initialize(args)
      puts PleaseValidate::Validator.file(args[0])
    end
  end
end