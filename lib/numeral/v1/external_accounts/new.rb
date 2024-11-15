# frozen_string_literal: true

module Numeral
  module V1
    module ExternalAccounts
      extend Helpers

      class << self
        def create(body: {})
          # type: own or virtual
          required_keys = %i[
            holder_name
            account_number
            bank_code
          ]
          optional_keys = %i[
            type
            name
            account_holder_id
            company_registration_number
            company_registration_number_type
            holder_address
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
