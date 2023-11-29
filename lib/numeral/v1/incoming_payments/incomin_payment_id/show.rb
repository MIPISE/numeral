# frozen_string_literal: true

module Numeral
  module V1
    module IncomingPayments
      module IncomingPaymentId
        extend Helpers

        class << self
          def get(incoming_payment_id)
            Numeral.get(generate_uri.gsub("incoming_payment_id", incoming_payment_id))
          end
        end
      end
    end
  end
end
