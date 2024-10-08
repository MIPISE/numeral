# frozen_string_literal: true

module Numeral
  module V1
    module Balances
      module BalanceId
        extend Helpers

        class << self
          def get(balance_id)
            Numeral.get(generate_uri.gsub("balance_id", balance_id))
          end
        end
      end
    end
  end
end
