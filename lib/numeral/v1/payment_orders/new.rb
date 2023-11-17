# frozen_string_literal: true

module Numeral
  module V1
    module PaymentOrders
      extend Helpers

      class << self
        def create(body: {})
          required_keys = %i[
            type
            direction
            amount
            currency
            connected_account_id
            reference
          ]

          optional_keys = %i[
            originating_account
            receiving_account
            receiving_account_id
            direct_debit_mandate
            direct_debit_mandate_id
            requested_execution_date
            auto_approval
            metadata
            idempotency-key
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
