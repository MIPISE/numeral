# frozen_string_literal: true

module Numeral
  module V1
    module VirtualAccounts
      module VirtualAccountId
        extend Helpers

        class << self
          def update(virtual_account_id, body: {})
            optional_keys = %i[metadata name]
            ensure_keys(body, [], optional_keys)

            Numeral.post(
              generate_uri.gsub("virtual_account_id", virtual_account_id),
              body
            )
          end

          def disable(virtual_account_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("virtual_account_id", virtual_account_id),
              {}
            )
          end
        end
      end
    end
  end
end
