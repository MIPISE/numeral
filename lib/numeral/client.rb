# frozen_string_literal: true

require "net/http"
require "json"

module Numeral
  module Client
    def get(uri)
      request(uri, method: "GET")
    end

    def post(uri, body)
      request(uri, body: body, method: "POST")
    end

    private

    def request(path, body: {}, method: "GET")
      uri = URI.parse("#{Numeral.configuration.url_api}/#{path}")
      headers = {
        "content-type": "application/json",
        accept: "application/json",
        "x-api-key": Numeral.configuration.api_key
      }
      headers.merge("idempotency-key" => body.delete("idempotency-key")) if !body["idempotency-key"].nil?
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.send_request(method, uri.to_s, body.to_json, headers)

      return {"error" => "not found"} if res.body == ""
      JSON.parse(res.body)
    end
  end
end
