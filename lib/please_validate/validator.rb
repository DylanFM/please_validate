module PleaseValidate
  
  class Validator

    class << self
      # Read requested file's contents and send to the w3c validator api then call the parse_response method to sort the response out.
      def file(file)
        begin
          raise "please specify a file to validate" unless file
          raise "the specified file doesn't exist" unless File.exist? file
          raise "the specified file must have a content type of text/html" unless file_valid? file
          response = File.open(file, 'r') do |f|
            Net::HTTP.start('validator.w3.org').post(
              '/check',
              "fragment=#{CGI.escape(f.read)}&output=xml",
              {'Content-Type' => 'application/x-www-form-urlencoded'}
            )
          end
          parse_response file, response
        end
      end
      
      # Takes an array of files and validates them all
      def files(files)
        files.collect { |file| self.file(file) }
      end

      # Takes an XML response from the file method's call to the w3c and parses it into a nice little hash
      def parse_response(filename, response)
        # Use Nokogiri to parse the xml
        response_data = Nokogiri::XML.parse(response.body)
        # Begin building the return hash
        result = { 
          :file => filename,
          :status => response['x-w3c-validator-status'].downcase.to_sym,
          :error_count => response['x-w3c-validator-errors'].to_i,
          :errors => Array.new
        }
        # Get meta elements like encoding and doctype
        response_data.css('result > meta *').each do |meta|
          next unless %w{encoding doctype}.include? meta.name
          result[meta.name.to_sym] = meta.content
        end
        # Get errors
        response_data.css('result messages msg').each do |error|
          result[:errors] << {
            :message => error.content,
            :line => error['line'].to_i,
            :col => error['col'].to_i
          }
        end
        result
      end
      
      # Takes a file path and checks to see if it's mime type is OK. Currently using the first mime type returned by the mime-types gem.
      def file_valid?(file)
        mime = MIME::Types.type_for(file).first
        !mime.nil? && ACCEPTED_MIMES.include?(mime.content_type)
      end
    end

  end
  
end