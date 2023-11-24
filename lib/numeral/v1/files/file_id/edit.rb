# frozen_string_literal: true

module Numeral
  module V1
    module Files
      module FileId
        extend Helpers

        class << self
          def approve(file_id)
            Numeral.post(generate_uri({}, "approve").gsub("file_id", file_id), {})
          end

          def cancel(file_id)
            Numeral.post(generate_uri({}, "cancel").gsub("file_id", file_id), {})
          end
        end
      end
    end
  end
end
