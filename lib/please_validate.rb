require 'net/http'
require 'cgi'

class PleaseValidate
  
  class << self
    def file(file_path)
      result = File.open(file_path, 'r') do |f|
        Net::HTTP.start('validator.w3.org').post('/check',"fragment=#{CGI.escape(f.read)}&output=xml")
      end
      { :status => result['x-w3c-validator-status'].downcase.to_sym }
    end
  end
  
end