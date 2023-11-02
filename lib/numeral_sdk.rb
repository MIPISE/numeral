# frozen_string_literal: true

require "dotenv/load"
require_relative "numeral_sdk/helpers"

Dir["./lib/numeral_sdk/**/*.rb"].each { |file| require file }

module NumeralSdk
  class << self
    include Configuration
    include Client
  end
end
