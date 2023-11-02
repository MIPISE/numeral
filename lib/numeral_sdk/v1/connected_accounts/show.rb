# frozen_string_literal: true

module NumeralSdk
  module V1
    module ConnectedAccounts
      extend Helpers

      class << self
        def get_accounts_list
          NumeralSdk.get(generate_uri)
        end
      end
    end
  end
end
