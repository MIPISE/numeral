# frozen_string_literal: true

module Numeral
  module V1
    module VirtualAccounts
      module VirtualAccountId
        module Counterparties
          module CounterpartyId
            extend Helpers

            class << self
              def assign(virtual_account_id, counterparty_id)
                Numeral.post(
                  generate_uri({}, "assign").gsub(
                    /\w*_id/,
                    "virtual_account_id" => virtual_account_id,
                    "counterparty_id" => counterparty_id
                  ),
                  {}
                )
              end

              def unassign(virtual_account_id, counterparty_id)
                Numeral.post(
                  generate_uri({}, "unassign").gsub(
                    /\w*_id/,
                    "virtual_account_id" => virtual_account_id,
                    "counterparty_id" => counterparty_id
                  ),
                  {}
                )
              end
            end
          end
        end
      end
    end
  end
end
