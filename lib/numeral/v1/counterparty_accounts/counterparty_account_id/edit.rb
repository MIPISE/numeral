# frozen_string_literal: true

module Numeral
  module V1
    module CounterpartyAccounts
      module CounterpartyAccountId
        extend Helpers

        class << self
          def update(counterparty_account_id, body: {})
            required_keys = %i[metadata]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri.gsub("counterparty_account_id", counterparty_account_id),
              body
            )
          end

          def disable(counterparty_account_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("counterparty_account_id", counterparty_account_id),
              {}
            )
          end
        end
      end
    end
  end
end
