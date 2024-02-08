# frozen_string_literal: true

require_relative "numeral/helpers"

Dir["./lib/numeral/**/*.rb"].each { |file| require_relative file.delete_prefix("./lib/") }

module Numeral
  class << self
    include Configuration
    include Client
  end
end
