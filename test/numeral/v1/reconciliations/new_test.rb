# frozen_string_literal: true

require_relative "../../../test_helper"

describe "Numeral::V1::Reconciliations#create" do
  it "creates a new reconciliation" do
    unreconciled_payment_orders = Numeral::V1::PaymentOrders.get_list(uri_opt: {direction: "debit", reconciliation_status: "unreconciled", connected_account_id: ENV["NUMERAL_SETTLEMENT_ACCOUNT_ID"], limit: 10}).dig("records")
    unreconciled_transaction = nil
    unreconciled_payment = nil
    unreconciled_payment_orders.each do |payment_order|
      po_amount = payment_order["amount"]
      unreconciled_transaction = Numeral::V1::Transactions.get_list(uri_opt: {direction: "debit", reconciliation_status: "unreconciled", amount_from: po_amount, amount_to: po_amount, connected_account_id: payment_order["connected_account_id"], limit: 1}).dig("records").first
      if unreconciled_transaction
        unreconciled_payment = payment_order
        break
      end
    end
    if unreconciled_transaction && unreconciled_payment
      res = Numeral::V1::Reconciliations.create(body: {transaction_id: unreconciled_transaction["id"], payment_id: unreconciled_payment["id"]})
      binding.irb
      assert res.is_a? Hash
      assert res["id"]
      assert_equal res["transaction_id"], unreconciled_transaction["id"]
      assert_equal res["payment_id"], unreconciled_payment["id"]
    else
      puts "Could not find any matching transaction for the first 10 unreconciled payment_orders on settlement account... Could not test reconciliation creation..."
    end
  end
end
