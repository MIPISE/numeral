# frozen_string_literal: true

require "date"
require "ox"

module BankSimulator
  class Base
    include Numeral::Helpers

    def initialize(**args)
      args.each { |k, v| instance_variable_set("@#{k}", v) }
      @connected_account = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first
    end

    def self.simulate(...)
      new(...).execute
    end

    def execute
      request(
        underscore(self.class.name).split("/").last,
        generate_xml
      )
    end

    def generate_xml
      doc = Ox::Document.new

      instruct = Ox::Instruct.new(:xml)
      instruct[:version] = "1.0"
      instruct[:encoding] = "UTF-8"
      doc << instruct

      yield(doc)

      Ox.dump(doc)
    end

    def request(filename, body)
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      uri = URI.parse(
        "#{Numeral.configuration.url_api}/v1/simulator/connected_accounts/#{@connected_account["id"]}/services/sct/bank_files/incoming/#{timestamp}.#{filename}.xml"
      )
      headers = {"content-type": "application/xml", "x-api-key": Numeral.configuration.api_key}

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.send_request("POST", uri.to_s, body, headers)

      JSON.parse(res.body)
    end
  end
end

Dir["./test/bank_simulator/xml/**/*.rb"].each { |f| require f }
