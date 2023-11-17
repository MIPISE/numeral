# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::PaymentOrders::PaymentOrderId#update" do
  before do
    @payment_order_id = Numeral::V1::PaymentOrders.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    @body = {
      metadata: {
        "test" => "test1"
      }
    }
  end

  it "render updated payment order" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.update(@payment_order_id, body: @body)

    assert res.is_a? Hash
    assert res.dig("id") == @payment_order_id
    assert res.dig("metadata") == @body[:metadata]
  end

  it "render error with invalid id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.update("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.update("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) {
      Numeral::V1::PaymentOrders::PaymentOrderId.update(@payment_order_id, body: @body)
    }
  end
end

describe "Numeral::V1::PaymentOrders::PaymentOrderId#approve" do
  it "render approved payment order" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      type: "sepa",
      direction: "credit",
      amount: 2000,
      currency: "EUR",
      connected_account_id: connected_account_id,
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
    payment_order_id = Numeral::V1::PaymentOrders.create(body: body)["id"]

    res = Numeral::V1::PaymentOrders::PaymentOrderId.approve(payment_order_id)

    assert res.is_a? Hash
    assert res.dig("id") == payment_order_id
    assert res.dig("status") == "approved"
  end

  it "render error with invalid id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.approve("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.approve("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end

describe "Numeral::V1::PaymentOrders::PaymentOrderId#cancel" do
  it "render canceled payment order" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      type: "sepa",
      direction: "credit",
      amount: 2000,
      currency: "EUR",
      connected_account_id: connected_account_id,
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
    payment_order_id = Numeral::V1::PaymentOrders.create(body: body)["id"]

    res = Numeral::V1::PaymentOrders::PaymentOrderId.cancel(payment_order_id)

    assert res.is_a? Hash
    assert res.dig("id") == payment_order_id
    assert res.dig("status") == "canceled"
  end

  it "render error with invalid id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.cancel("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.cancel("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end

describe "Numeral::V1::PaymentOrders::PaymentOrderId#retry" do
  it "retry payment order" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      type: "sepa",
      direction: "credit",
      amount: 2000,
      currency: "EUR",
      connected_account_id: connected_account_id,
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
    payment_order_id = Numeral::V1::PaymentOrders.create(body: body)["id"]

    res = Numeral::V1::PaymentOrders::PaymentOrderId.retry(payment_order_id)

    assert res.is_a? Hash
    assert res.dig("error") == "status"
    assert res.dig("message") == "only payment orders with status rejected or returned can be retried"
  end

  it "render error with invalid id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.retry("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::PaymentOrders::PaymentOrderId.retry("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
