# frozen_string_literal: true

module NumeralSdk
  module V1
    module ConnectedAccounts
      extend Helpers

      class << self
        def get_accounts_list(opt: {})
          ensure_keys(opt, [], %i[limit starting_after sort_order start_date end_date])

          NumeralSdk.get(generate_uri(opt))
        end
      end
    end
  end
end
