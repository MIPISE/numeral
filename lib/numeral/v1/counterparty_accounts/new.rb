# frozen_string_literal: true

module Numeral
  module V1
    module CounterpartyAccounts
      extend Helpers

      class << self
        def create(body: {})
          required_keys = %i[
            holder_name
            account_number
            bank_code
          ]
          optional_keys = %i[
            counterparty_id
            holder_address
            name
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
