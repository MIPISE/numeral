# frozen_string_literal: true

module Numeral
  module V1
    module ReturnRequests
      module ReturnRequestId
        extend Helpers

        class << self
          def get(return_request_id)
            Numeral.get(generate_uri.gsub("return_request_id", return_request_id))
          end
        end
      end
    end
  end
end
