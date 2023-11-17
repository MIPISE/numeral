# frozen_string_literal: true

module Numeral
  module V1
    module VirtualAccounts
      module VirtualAccountId
        extend Helpers

        class << self
          def get(virtual_account_id)
            Numeral.get(generate_uri.gsub("virtual_account_id", virtual_account_id))
          end
        end
      end
    end
  end
end
