# frozen_string_literal: true

module Numeral
  module V1
    module IncomingPayments
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            connected_account_id
            start_date
            end_date
            type
            direction
            status
            start_value_date
            end_value_date
            amount_from
            amount_to
            mandate_reference
            file_id
            reconciliation_status
            aggregation_reference
            direct_debit_mandate_id
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
