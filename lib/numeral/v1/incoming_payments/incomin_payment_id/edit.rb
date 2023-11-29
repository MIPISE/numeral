# frozen_string_literal: true

module Numeral
  module V1
    module IncomingPayments
      module IncomingPaymentId
        extend Helpers

        class << self
          def update(incoming_payment_id, body: {})
            optional_keys = %i[metadata]
            ensure_keys(body, [], optional_keys)

            Numeral.post(
              generate_uri.gsub("incoming_payment_id", incoming_payment_id),
              body
            )
          end

          def reject(incoming_payment_id, body: {})
            required_keys = %i[reason]
            ensure_keys(body, required_keys, [])

            Numeral.post(
              generate_uri({}, "reject").gsub("incoming_payment_id", incoming_payment_id),
              body
            )
          end

          def confirm(incoming_payment_id)
            Numeral.post(
              generate_uri({}, "confirm").gsub("incoming_payment_id", incoming_payment_id),
              {}
            )
          end
        end
      end
    end
  end
end
