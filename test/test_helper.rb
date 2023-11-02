# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "numeral_sdk"

require "minitest/autorun"
require "minitest/reporters"

NumeralSdk.configure do |conf|
  conf.url_api = ENV["NUMERAL_URL_API"]
  conf.api_key = ENV["NUMERAL_API_KEY"]
end

Minitest::Reporters.use!
