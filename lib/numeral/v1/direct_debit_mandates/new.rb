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
          ]
          optional_keys = %i[
            connected_account_id
            generate_mandate_reference
            originating_account
            metadata
            receiving_account
            receiving_account_id
            reference
            signature_date
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
