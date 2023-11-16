# frozen_string_literal: true

module Numeral
  module V1
    module DirectDebitMandates
      extend Helpers

      class << self
        def create(body: {})
          required_keys = %i[
            direction
            type
            sequence
            reference
            signature_date
          ]
          optional_keys = %i[
            connected_account_id
            receiving_account_id
            originating_account
            receiving_account
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
