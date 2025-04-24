# frozen_string_literal: true

module Numeral
  module Configuration
    extend Helpers

    def configuration
      @configuration ||= OpenStruct.new
    end

    def configure
      yield(configuration)

      Numeral::Configuration.ensure_keys(configuration.to_h, %i[api_key url_api], %i[cert_private_key cert])
    end
  end
end
