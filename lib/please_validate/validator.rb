module PleaseValidate
  
  class Validator

    class << self
      # Read requested file's contents and send to the w3c validator api then call the parse_response method to sort the response out.
      def file(file_path)
        begin
          raise "Please specify a file to validate" unless file_path
          raise "The specified file doesn't exist" unless File.exist?(file_path)
          response = File.open(file_path, 'r') do |f|
            Net::HTTP.start('validator.w3.org').post(
              '/check',
              "fragment=#{CGI.escape(f.read)}&output=xml",
              {'Content-Type' => 'application/x-www-form-urlencoded'}
            )
          end
          parse_response response
        rescue Exception => e
          puts e
          raise
        end
        
      end

      # Takes an XML response from the file method's call to the w3c and parses it into a nice little hash
      def parse_response(response)
        # Use Nokogiri to parse the xml
        response_data = Nokogiri::XML.parse(response.body)
        # Begin building the return hash
        result = { 
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
    end

  end
  
end