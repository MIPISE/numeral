# frozen_string_literal: true

module Numeral
  module V1
    module DirectDebitMandates
      module DirectDebitMandateId
        extend Helpers

        class << self
          def update(direct_debit_mandate_id, body: {})
            required_keys = %i[metadata]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri.gsub("direct_debit_mandate_id", direct_debit_mandate_id),
              body
            )
          end

          def disable(direct_debit_mandate_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("direct_debit_mandate_id", direct_debit_mandate_id),
              {}
            )
          end

          def block(direct_debit_mandate_id)
            Numeral.post(
              generate_uri({}, "block").gsub("direct_debit_mandate_id", direct_debit_mandate_id),
              {}
            )
          end

          def authorize(direct_debit_mandate_id)
            Numeral.post(
              generate_uri({}, "authorize").gsub("direct_debit_mandate_id", direct_debit_mandate_id),
              {}
            )
          end
        end
      end
    end
  end
end
