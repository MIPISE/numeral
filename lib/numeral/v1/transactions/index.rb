# frozen_string_literal: true

module Numeral
  module V1
    module Transactions
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            start_date
            end_date
            start_booking_date
            end_booking_date
            start_value_date
            end_value_date
            direction
            currency
            counterparty_account_number
            counterparty_name
            amount_from
            amount_to
            virtual_account_number
            connected_account_id
            file_id
            category
            reconciliation_status
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
