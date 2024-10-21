# frozen_string_literal: true

module Numeral
  module V1
    module Reconciliations
      extend Helpers

      class << self
        def create(body: {})
          required_keys = %i[
            transaction_id
            payment_id
          ]

          optional_keys = %i[
            amount
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
