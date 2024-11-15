# frozen_string_literal: true

module Numeral
  module V1
    module InternalAccounts
      module InternalAccountId
        extend Helpers

        class << self
          def disable(internal_account_id)
            Numeral.post(
              generate_uri({}, "disable").gsub("internal_account_id", internal_account_id),
              {}
            )
          end
        end
      end
    end
  end
end
