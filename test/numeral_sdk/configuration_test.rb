# frozen_string_literal: true

require "test_helper"

describe "Configuration" do
  describe "#configuration" do
    it "render OpenStruct object" do
      assert NumeralSdk.configuration.instance_of? OpenStruct
    end
  end

  describe "#configure" do
    before do
      (conf = NumeralSdk.configuration)
        .to_h
        .keys
        .each{ |key| conf.delete_field(key) }
    end

    it "configuration work correctly" do
      NumeralSdk.configure do |conf|
        conf.api_key = "api_key"
        conf.url_api = "url_api"
      end
      assert NumeralSdk.configuration.api_key == "api_key"
      assert NumeralSdk.configuration.url_api == "url_api"
    end

    it "raise error when key not recognized" do
      assert_raises(ArgumentError) { NumeralSdk.configure { |conf| conf.api_test = "api_test" } }
    end

    it "raise error when required keys missing" do
      assert_raises(ArgumentError) { NumeralSdk.configure { |conf| conf.api_test = "api_key" } }
    end
  end
end
