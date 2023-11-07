# frozen_string_literal: true

require "test_helper"

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

    it "configuration work correctly" do
      Numeral.configure do |conf|
        conf.api_key = "api_key"
        conf.url_api = "url_api"
      end
      assert Numeral.configuration.api_key == "api_key"
      assert Numeral.configuration.url_api == "url_api"
    end

    it "raise error when key not recognized" do
      assert_raises(ArgumentError) { Numeral.configure { |conf| conf.api_test = "api_test" } }
    end

    it "raise error when required keys missing" do
      assert_raises(ArgumentError) { Numeral.configure { |conf| conf.api_test = "api_key" } }
    end
  end
end
