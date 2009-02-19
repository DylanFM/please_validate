class PleaseValidate
  
  class << self
    def file(file)
      @file = file
      { :status => :valid }
    end
  end
  
end