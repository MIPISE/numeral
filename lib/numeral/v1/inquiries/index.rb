# frozen_string_literal: true

module Numeral
  module V1
    module Inquiries
      extend Helpers

      class << self
        def get_list(uri_opt: {})
          permitted_uri_opt = %i[
            limit
            starting_after
            sort_order
            connected_account_id
            denied
            start_date
            end_date
            related_request_type
            file_id
          ]
          ensure_keys(uri_opt, [], permitted_uri_opt)

          Numeral.get(generate_uri(uri_opt))
        end
      end
    end
  end
end
