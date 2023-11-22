# frozen_string_literal: true

module Numeral
  module V1
    module Inquiries
      module InquiryId
        extend Helpers

        class << self
          def deny(inquiry_id, body: {})
            required_keys = %i[reason]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri({}, "deny").gsub("inquiry_id", inquiry_id),
              body
            )
          end
        end
      end
    end
  end
end
