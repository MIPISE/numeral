# frozen_string_literal: true

module NumeralSdk
  module V1
    module ConnectedAccounts
      module AccountId
        extend Helpers

        class << self
          def get(account_id)
            NumeralSdk.get(generate_uri.gsub("account_id", account_id))
          end
        end
      end
    end
  end
end
