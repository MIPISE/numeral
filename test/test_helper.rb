# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "dotenv/load"
require "numeral"
require "minitest/autorun"
require "minitest/reporters"
require_relative "bank_simulator/base"

Numeral.configure do |conf|
  conf.url_api = ENV["NUMERAL_URL_API"]
  conf.api_key = ENV["NUMERAL_API_KEY"]
end

Minitest::Reporters.use!
