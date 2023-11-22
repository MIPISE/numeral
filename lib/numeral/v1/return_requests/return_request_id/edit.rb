# frozen_string_literal: true

module Numeral
  module V1
    module ReturnRequests
      module ReturnRequestId
        extend Helpers

        class << self
          def accept(return_request_id)
            Numeral.post(
              generate_uri({}, "accept").gsub("return_request_id", return_request_id),
              {}
            )
          end

          def deny(return_request_id)
            Numeral.post(
              generate_uri({}, "deny").gsub("return_request_id", return_request_id),
              {}
            )
          end
        end
      end
    end
  end
end
