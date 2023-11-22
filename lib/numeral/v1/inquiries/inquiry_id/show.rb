# frozen_string_literal: true

module Numeral
  module V1
    module Inquiries
      module InquiryId
        extend Helpers

        class << self
          def get(inquiry_id)
            Numeral.get(generate_uri.gsub("inquiry_id", inquiry_id))
          end
        end
      end
    end
  end
end
