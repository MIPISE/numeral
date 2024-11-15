# frozen_string_literal: true

module Numeral
  module V1
    module AccountHolders
      module AccountHolderId
        extend Helpers

        class << self
          def get(account_holder_id)
            Numeral.get(generate_uri.gsub("account_holder_id", account_holder_id))
          end
        end
      end
    end
  end
end
