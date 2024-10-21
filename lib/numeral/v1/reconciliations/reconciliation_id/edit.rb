# frozen_string_literal: true

module Numeral
  module V1
    module Reconciliations
      module ReconciliationId
        extend Helpers

        class << self
          def update(reconciliation_id, body: {})
            optional_keys = %i[metadata]
            ensure_keys(body, [], optional_keys)

            Numeral.post(
              generate_uri.gsub("reconciliation_id", reconciliation_id),
              body
            )
          end

          def cancel(reconciliation_id, body: {})
            ensure_keys(body, %i[metadata], [])

            Numeral.post(generate_uri({}, "cancel").gsub("reconciliation_id", reconciliation_id), body)
          end
        end
      end
    end
  end
end
