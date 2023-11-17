# frozen_string_literal: true

module Numeral
  module V1
    module VirtualAccounts
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            start_date
            end_date
            name
            virtual_account_number
            connected_account_id
            counterparty_id
            disabled
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
