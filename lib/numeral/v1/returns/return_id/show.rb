# frozen_string_literal: true

module Numeral
  module V1
    module Returns
      module ReturnId
        extend Helpers

        class << self
          def get(return_id)
            Numeral.get(generate_uri.gsub("return_id", return_id))
          end
        end
      end
    end
  end
end
