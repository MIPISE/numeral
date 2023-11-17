# frozen_string_literal: true

module Numeral
  module V1
    module VirtualAccounts
      extend Helpers

      class << self
        def create(body: {})
          required_keys = %i[
            virtual_account_number
            connected_account_id
          ]
          optional_keys = %i[
            name
            counterparty_id
            metadata
          ]
          ensure_keys(body, required_keys, optional_keys)

          Numeral.post(generate_uri, body)
        end
      end
    end
  end
end
