module PleaseValidate
  
  class Validator

    class << self
      def file(file_path)
        response = File.open(file_path, 'r') do |f|
          Net::HTTP.start('validator.w3.org').post(
            '/check',
            "fragment=#{CGI.escape(f.read)}&output=xml",
            {'Content-Type' => 'application/x-www-form-urlencoded'}
          )
        end
        parse_response response
      end

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