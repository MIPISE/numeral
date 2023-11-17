# frozen_string_literal: true

module Numeral
  module V1
    module PaymentOrders
      module PaymentOrderId
        extend Helpers

        class << self
          def update(payment_order_id, body: {})
            optional_keys = %i[metadata status status_details]
            ensure_keys(body, [], optional_keys)

            Numeral.post(
              generate_uri.gsub("payment_order_id", payment_order_id),
              body
            )
          end

          def approve(payment_order_id)
            Numeral.post(
              generate_uri({}, "approve").gsub("payment_order_id", payment_order_id),
              {}
            )
          end

          def cancel(payment_order_id)
            Numeral.post(
              generate_uri({}, "cancel").gsub("payment_order_id", payment_order_id),
              {}
            )
          end

          def retry(payment_order_id, body: {})
            optional_keys = %i[connected_account_id type requested_execution_date idempotency-key]
            ensure_keys(body, [], optional_keys)

            Numeral.post(
              generate_uri({}, "retry").gsub("payment_order_id", payment_order_id),
              body
            )
          end
        end
      end
    end
  end
end
