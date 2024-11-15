# frozen_string_literal: true

module Numeral
  module V1
    module AccountHolders
      module AccountHolderId
        extend Helpers

        class << self
          def update(account_holder_id, body: {})
            required_keys = %i[metadata]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri.gsub("account_holder_id", account_holder_id),
              body
            )
          end

          def disable(account_holder_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("account_holder_id", account_holder_id),
              {}
            )
          end
        end
      end
    end
  end
end
