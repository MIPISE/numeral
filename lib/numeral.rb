# frozen_string_literal: true

require "dotenv/load"
require_relative "numeral/helpers"

Dir["./lib/numeral/**/*.rb"].each { |file| require file }

module Numeral
  class << self
    include Configuration
    include Client
  end
end
