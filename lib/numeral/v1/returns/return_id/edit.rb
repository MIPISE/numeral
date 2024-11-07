# frozen_string_literal: true

module Numeral
  module V1
    module Returns
      module ReturnId
        extend Helpers

        class << self
          def approve(return_id)
            Numeral.post(
              generate_uri({}, "approve").gsub("return_id", return_id),
              {}
            )
          end

          def cancel(return_id)
            Numeral.post(
              generate_uri({}, "cancel").gsub("return_id", return_id),
              {}
            )
          end
        end
      end
    end
  end
end
