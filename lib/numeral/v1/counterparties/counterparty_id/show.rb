# frozen_string_literal: true

module Numeral
  module V1
    module Counterparties
      module CounterpartyId
        extend Helpers

        class << self
          def get(counterparty_id)
            Numeral.get(generate_uri.gsub("counterparty_id", counterparty_id))
          end
        end
      end
    end
  end
end
