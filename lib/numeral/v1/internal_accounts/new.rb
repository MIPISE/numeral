# frozen_string_literal: true

module Numeral
  module V1
    module InternalAccounts
      extend Helpers

      class << self
        def create(body: {})
          # type: own or virtual
          required_keys = %i[
            connected_account_ids
            type
            name
            holder_name
            account_number
          ]
          optional_keys = %i[
            bank_code
            account_holder_id
            holder_address
            creditor_identifier
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
