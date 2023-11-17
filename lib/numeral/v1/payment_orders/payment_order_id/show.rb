# frozen_string_literal: true

module Numeral
  module V1
    module PaymentOrders
      module PaymentOrderId
        extend Helpers

        class << self
          def get(payment_order_id)
            Numeral.get(generate_uri.gsub("payment_order_id", payment_order_id))
          end
        end
      end
    end
  end
end
