# frozen_string_literal: true

module Numeral
  module V1
    module Files
      module FileId
        extend Helpers

        class << self
          def get(file_id)
            Numeral.get(generate_uri.gsub("file_id", file_id))
          end
        end
      end
    end
  end
end
