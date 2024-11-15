# frozen_string_literal: true

module Numeral
  module V1
    module ExternalAccounts
      module ExternalAccountId
        extend Helpers

        class << self
          def get(external_account_id)
            Numeral.get(generate_uri.gsub("external_account_id", external_account_id))
          end
        end
      end
    end
  end
end
