# frozen_string_literal: true

module Numeral
  module V1
    module DirectDebitMandates
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            start_date
            end_date
            start_signature_date
            end_signature_date
            receiving_account_id
            type
            sequence
            reference
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
