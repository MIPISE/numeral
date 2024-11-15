# frozen_string_literal: true

module Numeral
  module V1
    module InternalAccounts
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            start_date
            end_date
            connected_account_id
            name
            type
            account_number
            bank_code
            creditor_identifier
            account_holder_id
            holder_name
            status
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
