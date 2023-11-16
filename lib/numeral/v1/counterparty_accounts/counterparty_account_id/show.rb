# frozen_string_literal: true

module Numeral
  module V1
    module CounterpartyAccounts
      module CounterpartyAccountId
        extend Helpers

        class << self
          def get(counterparty_account_id)
            Numeral.get(generate_uri.gsub("counterparty_account_id", counterparty_account_id))
          end
        end
      end
    end
  end
end
