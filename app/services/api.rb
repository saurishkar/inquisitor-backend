# frozen_string_literal: true

require 'uri'
require 'net/http'
module Api
  class ApiService
    def self.post(url = '', config = {})
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request['content-type'] = config['content-type']
      request['api_key'] = config['api_key']
      request.body = config['body']
      http.request(request)
    end

    def self.get; end

    def self.put; end

    def self.patch; end
  end
end
