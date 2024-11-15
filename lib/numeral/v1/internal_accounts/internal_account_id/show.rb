# frozen_string_literal: true

module Numeral
  module V1
    module InternalAccounts
      module InternalAccountId
        extend Helpers

        class << self
          def get(internal_account_id)
            Numeral.get(generate_uri.gsub("internal_account_id", internal_account_id))
          end
        end
      end
    end
  end
end
