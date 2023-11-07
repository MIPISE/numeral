# frozen_string_literal: true

module Numeral
  module V1
    module ConnectedAccounts
      module AccountId
        extend Helpers

        class << self
          def get(account_id)
            Numeral.get(generate_uri.gsub("account_id", account_id))
          end
        end
      end
    end
  end
end
