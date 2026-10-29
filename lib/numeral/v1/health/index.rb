# frozen_string_literal: true

module Numeral
  module V1
    module Health
      extend Helpers

      class << self
        def ping
          Numeral.get(generate_uri({}))
        end
      end
    end
  end
end
