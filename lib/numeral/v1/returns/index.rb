# frozen_string_literal: true

module Numeral
  module V1
    module Returns
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            connected_account_id
            type
            return_type
            status
            related_payment_id
            related_payment_type
            start_date
            end_date
            start_value_date
            end_value_date
            reconciliation_status
            file_id
            aggregation_reference
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
