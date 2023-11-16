# frozen_string_literal: true

module Numeral
  module V1
    module Counterparties
      module CounterpartyId
        extend Helpers

        class << self
          def update(counterparty_id, body: {})
            required_keys = %i[metadata]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri.gsub("counterparty_id", counterparty_id),
              body
            )
          end

          def disable(counterparty_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("counterparty_id", counterparty_id),
              {}
            )
          end
        end
      end
    end
  end
end
