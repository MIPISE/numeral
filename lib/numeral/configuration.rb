# frozen_string_literal: true

module Numeral
  module Configuration
    extend Helpers

    def configuration
      @configuration ||= OpenStruct.new
    end

    def configure
      yield(configuration)

      Numeral::Configuration.ensure_keys(configuration.to_h, %i[api_key url_api])
    end
  end
end
