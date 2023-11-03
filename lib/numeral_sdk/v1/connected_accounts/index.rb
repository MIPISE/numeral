# frozen_string_literal: true

module NumeralSdk
  module V1
    module ConnectedAccounts
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            start_date
            end_date
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          NumeralSdk.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
