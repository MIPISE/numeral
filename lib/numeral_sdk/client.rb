# frozen_string_literal: true

require "net/http"
require "json"

module NumeralSdk
  module Client
    def get(uri)
      request(uri, method: "GET")
    end

    def post(uri, body)
      request(uri, body: body, method: "POST")
    end

    def put(uri, body)
      request(uri, body: body, method: "PUT")
    end

    private

    def request(path, body: {}, method: "GET")
      uri = URI.parse("#{NumeralSdk.configuration.url_api || ENV["NUMERAL_URL_API"]}/#{path}")
      http_args = [uri.host, uri.port]
      headers = {
        "content-type" => "application/json",
        "accept" => "application/json",
        "x-api-key" => NumeralSdk.configuration.api_key || ENV["NUMERAL_API_KEY"]
      }
      headers.merge("idempotency-key" => body.delete("idempotency-key")) if !body["idempotency-key"].nil?

      http = Net::HTTP.new(*http_args)
      http.use_ssl = true
      res = http.send_request(method, uri.path, body.to_json, headers)
      JSON.parse(res.body)
    end
  end
end
