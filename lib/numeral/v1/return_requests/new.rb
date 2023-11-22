# frozen_string_literal: true

module Numeral
  module V1
    module ReturnRequests
      extend Helpers

      class << self
        def create(body: {})
          required_keys = %i[
            related_payment_id
            return_reason
          ]

          optional_keys = %i[
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
