# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::PaymentOrders#create" do
  before do
    @body = {
      type: "sepa",
      direction: "credit",
      amount: 2000,
      currency: "EUR",
      connected_account_id: "fake-id",
      originating_account: {
        account_number: "FR5010096000509667543811M39",
        bank_code: "SOMEBIC0XXX",
        holder_name: "Test & Co"
      },
      receiving_account: {
        account_number: "FR5210096000401636223344Q31",
        bank_code: "SOMEBIC0XXX",
        holder_name: "Test & Co 2"
      },
      reference: "test-#{SecureRandom.hex(10)}",
      "idempotency-key": SecureRandom.uuid
    }
  end
  it "create new payment order" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    @body[:connected_account_id] = connected_account_id

    response = Numeral::V1::PaymentOrders.create(body: @body)
    assert !response["id"].nil?
    assert response["object"] == "payment_order"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"

    assert_raises(ArgumentError) { Numeral::V1::PaymentOrders.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:amount)
    assert_raises(ArgumentError) { Numeral::V1::PaymentOrders.create(body: @body) }
  end
end
