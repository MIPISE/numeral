# frozen_string_literal: true

module Numeral
  module Helpers
    def generate_uri(opt = {})
      options = opt.map { |key, value| "#{key}=#{value}" }.join("&") if opt.any?

      uri = underscore(name.delete_prefix("Numeral::"))
      uri += "?#{options}" if !options.nil?
      uri
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

    def underscore(string)
      string.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr("-", "_")
        .downcase
    end
  end
end
