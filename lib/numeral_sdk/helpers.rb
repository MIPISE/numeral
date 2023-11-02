# frozen_string_literal: true

module NumeralSdk
  module Helpers
    def generate_uri
      name.split("::")[1..].join("/").downcase
    end

    def ensure_keys(hash, required_keys = %i[], optional_keys = %i[])
      hash.keys.each do |key|
        unless (valid_keys = required_keys + optional_keys).include?(key)
          raise(
            ArgumentError,
            "Unknown key: #{key.inspect}. Valid keys are: #{valid_keys.map(&:inspect).join(", ")}"
          )
        end
      end

      required_keys.each do |key|
        unless hash.has_key?(key)
          raise ArgumentError, "Required key not found: #{key}"
        end
      end

      hash
    end
  end
end
