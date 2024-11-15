# frozen_string_literal: true

module Numeral
  module V1
    module ExternalAccounts
      module ExternalAccountId
        extend Helpers

        class << self
          def update(external_account_id, body: {})
            required_keys = %i[metadata]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri.gsub("external_account_id", external_account_id),
              body
            )
          end
          
          def approve(external_account_id)
            Numeral.post(
              generate_uri({}, "approve").gsub("external_account_id", external_account_id),
              {}
            )
          end

          def deny(external_account_id, reason = nil)
            Numeral.post(
              generate_uri({}, "deny").gsub("external_account_id", external_account_id),
              {reason: reason}
            )
          end

          def verify(external_account_id)
            Numeral.post(
              generate_uri({}, "deny").gsub("verify", external_account_id),
              {}
            )
          end

          def disable(external_account_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("external_account_id", external_account_id),
              {}
            )
          end
        end
      end
    end
  end
end
