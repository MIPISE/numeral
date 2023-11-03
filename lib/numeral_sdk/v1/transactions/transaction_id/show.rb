# frozen_string_literal: true

module NumeralSdk
  module V1
    module Transactions
      module TransactionId
        extend Helpers

        class << self
          def get(transaction_id)
            NumeralSdk.get(generate_uri.gsub("transaction_id", transaction_id))
          end
        end
      end
    end
  end
end
