# frozen_string_literal: true

module Numeral
  module V1
    module Reconciliations
      module ReconciliationId
        extend Helpers

        class << self
          def get(reconciliation_id)
            Numeral.get(generate_uri.gsub("reconciliation_id", reconciliation_id))
          end
        end
      end
    end
  end
end
