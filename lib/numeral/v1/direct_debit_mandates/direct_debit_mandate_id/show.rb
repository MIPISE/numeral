# frozen_string_literal: true

module Numeral
  module V1
    module DirectDebitMandates
      module DirectDebitMandateId
        extend Helpers

        class << self
          def get(direct_debit_mandate_id)
            Numeral.get(generate_uri.gsub("direct_debit_mandate_id", direct_debit_mandate_id))
          end
        end
      end
    end
  end
end
