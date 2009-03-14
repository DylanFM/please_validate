require 'rubygems'
require 'net/http'
require 'cgi'
require 'nokogiri'
require 'mime/types'

Dir.glob(File.join(File.dirname(__FILE__), "please_validate", "*.rb")).each { |f| require f }

module PleaseValidate
  VERSION = '0.0.2'
  ACCEPTED_MIMES = ['text/html']
end