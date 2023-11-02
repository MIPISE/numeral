# frozen_string_literal: true

module NumeralSdk
  module Configuration
    extend Helpers

    def configuration
      @configuration ||= OpenStruct.new
    end

    def configure
      yield(configuration)

      NumeralSdk::Configuration.ensure_keys(configuration.to_h, %i[api_key url_api])
    end
  end
end
