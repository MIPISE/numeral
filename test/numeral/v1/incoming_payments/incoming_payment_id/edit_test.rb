# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::IncomingPayments::IncomingPaymentId#update" do
  before do
    @body = {
      metadata: {
        "test" => "test1"
      }
    }
  end

  it "render updated incoming payment" do
    BankSimulator::Xml::IncomingPayments::Create.simulate(amount: 100)
    return_id = Numeral::V1::IncomingPayments.get_list(uri_opt: {limit: "1"})["records"].last["id"]

    res = Numeral::V1::IncomingPayments::IncomingPaymentId.update(return_id, body: @body)

    assert res.is_a? Hash
    assert res.dig("id") == return_id
    assert res.dig("metadata") == @body[:metadata]
  end

  it "render error with invalid id" do
    res = Numeral::V1::IncomingPayments::IncomingPaymentId.update("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::IncomingPayments::IncomingPaymentId.update("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end

  it "render error with not recognized body key" do
    BankSimulator::Xml::IncomingPayments::Create.simulate(amount: 100)
    return_id = Numeral::V1::IncomingPayments.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    @body[:test] = "test"
    assert_raises(ArgumentError) {
      Numeral::V1::IncomingPayments::IncomingPaymentId.update(return_id, body: @body)
    }
  end
end

describe "Numeral::V1::IncomingPayments::IncomingPaymentId#reject" do
  # only incoming payments with status pending_confirmation can be rejected
end

describe "Numeral::V1::IncomingPayments::IncomingPaymentId#confirm" do
  # only incoming payments with status pending_confirmation can be confirmed
end
