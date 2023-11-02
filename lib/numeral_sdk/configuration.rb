# frozen_string_literal: true

module NumeralSdk
  module Configuration
    def configuration
      @configuration ||= OpenStruct.new
    end

    def configure
      yield(configuration)
    end
  end
end
