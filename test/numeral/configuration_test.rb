# frozen_string_literal: true

require_relative "../test_helper"

describe "Configuration" do
  describe "#configuration" do
    it "render OpenStruct object" do
      assert Numeral.configuration.instance_of? OpenStruct
    end
  end

  describe "#configure" do
    before do
      (conf = Numeral.configuration)
        .to_h
        .keys
        .each { |key| conf.delete_field(key) }
    end

    after do
      (conf = Numeral.configuration)
        .to_h
        .keys
        .each { |key| conf.delete_field(key) }
      conf.url_api = ENV["NUMERAL_URL_API"]
      conf.api_key = ENV["NUMERAL_API_KEY"]
    end

    it "configuration work correctly" do
      Numeral.configure do |conf|
        conf.api_key = "api_key"
        conf.url_api = "url_api"
        conf.cert = "cert"
        conf.cert_private_key = "cert_private_key"
      end
      assert Numeral.configuration.api_key == "api_key"
      assert Numeral.configuration.url_api == "url_api"
      assert Numeral.configuration.cert == "cert"
      assert Numeral.configuration.cert_private_key == "cert_private_key"
    end

    it "raise error when key not recognized" do
      assert_raises(ArgumentError) { Numeral.configure { |conf| conf.api_test = "api_test" } }
    end

    it "raise error when required keys missing" do
      assert_raises(ArgumentError) { Numeral.configure { |conf| conf.api_key = "api_key" } }
    end
  end
end
