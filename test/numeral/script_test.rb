# # frozen_string_literal: true
#
# require_relative "../test_helper"
# describe "" do
#   it "Should work..." do
#     safeguarding_connected_account_id = "7c023fe1-8456-42c9-9603-df3eb38e5d48"
#     settlement_connected_account_id = "b50f7d92-240d-4b40-9bc8-a28b4ec18ed5"
#     technical_connected_account_id = "ea68c563-c54d-4bc3-8563-00c7a4e4f7af"
#     # The only Financial Institution account that is working for IncomingPayment :
#     5.times do
#     amount = SecureRandom.random_number(100..5000) / 100.0
#       NumeralBankSimulator::Simulator::Xml::IncomingPayments::Create.simulate(amount: amount, connected_account_id: technical_connected_account_id)
#       ip_id = Numeral::V1::IncomingPayments.get_list(uri_opt: {limit: "1"})["records"].last["id"]
#       res_ip = Numeral::V1::IncomingPayments::IncomingPaymentId.get(ip_id)
#       today_date = Date.today
#       NumeralBankSimulator::Simulator::Xml::TransactionsAndBalances::Create.simulate(connected_account_id: settlement_connected_account_id, balances: [{type: "OPBD", amount: amount, direction: "CRDT", date: today_date}], direction: "CRDT", transactions: [{debitor_iban: res_ip["originating_account"]["account_number"], amount: amount, booking_date: today_date, value_date: today_date, }])
#     end
#     binding.irb
#     safe_account = Numeral::V1::ConnectedAccounts::AccountId.get(safeguarding_connected_account_id)
#     receiving_account_id = Numeral::V1::CounterpartyAccounts.get_list(uri_opt: {account_number: safe_account["account_number"]}).dig("records")&.first["id"]
#     params = { type: "sepa", direction: "credit", amount: 80000, currency: "EUR", connected_account_id: settlement_connected_account_id, reference: SecureRandom.hex(6), receiving_account_id: receiving_account_id }
#     Numeral::V1::PaymentOrders.create(body: params)
#     NumeralBankSimulator::Simulator::Xml::TransactionsAndBalances::Create.simulate(connected_account_id: settlement_connected_account_id, balances: [{type: "OPBD", amount: amount, direction: "CRDT", date: today_date}], direction: "CRDT", transactions: [{debitor_iban: res_ip["originating_account"]["account_number"], amount: amount, booking_date: today_date, value_date: today_date, }])
#   end
# end
