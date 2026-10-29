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
            frequency
          ]
          optional_keys = %i[
            connected_account_id
            creditor_account
            creditor_account_id
            debtor_account
            debtor_account_id
            generate_mandate_reference
            metadata
            reference
            signature_date
            originating_account
            receiving_account
            receiving_account_id
            sequence
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
