require 'json'

module SmsAero2
  class Request
    class HttpError < SmsAero2::Error; end
    class InvalidResponse < SmsAero2::Error; end

    attr_reader :client, :logger

    def initialize(client)
      @client = client
      @logger = client.logger
    end

    def call(url, **params)
      uri = URI(url)
      uri.query = URI.encode_www_form(params)

      response = send_request(uri)
      logger&.info(
          "Send http request to GET #{url} with params: #{params}"
      )
      response_body(response)

    rescue SmsAero2::Error => e
      logger&.error("http request to #{url} with params: #{params} is failed message: #{e.message}")
      raise e
    end

    private

    def send_request(uri)
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(client.login, client.api_token)
      request['Content-Type'] = 'application/json'
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    end

    def response_body(response)
      body = response.read_body
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(body)
      else
        raise HttpError, "server return error code: #{response.code} response: #{body}"
      end
    rescue JSON::ParserError
      raise InvalidResponse, "server return invalid response: #{body}"
    end
  end
end
