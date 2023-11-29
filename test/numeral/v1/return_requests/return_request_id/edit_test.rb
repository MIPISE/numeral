# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::ReturnRequests::ReturnRequestId#accept" do
  it "render accepted return request" do
    BankSimulator::Xml::IncomingPayments::Create.simulate(amount: 200)
    incoming_payment = Numeral::V1::IncomingPayments.get_list(uri_opt: {limit: "1"})["records"].last
    BankSimulator::Xml::ReturnRequests::Create.simulate(incoming_payment: incoming_payment)

    res = Numeral::V1::ReturnRequests.get_list(uri_opt: {status: "received", related_payment_id: incoming_payment["id"]})["records"].last
    res = Numeral::V1::ReturnRequests::ReturnRequestId.accept(res["id"])
    assert res["return_request"].is_a? Hash
    assert res["return_request"].dig("related_payment_id") == incoming_payment["id"]
    assert res["return_request"].dig("status") == "accepted"
  end

  it "render error with invalid id" do
    res = Numeral::V1::ReturnRequests::ReturnRequestId.accept("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::ReturnRequests::ReturnRequestId.accept("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end

describe "Numeral::V1::ReturnRequests::ReturnRequestId#deny" do
  before do
    @body = {
      return_reason: "AC06"
    }
  end

  it "render denied return request" do
    BankSimulator::Xml::IncomingPayments::Create.simulate(amount: 200)
    incoming_payment = Numeral::V1::IncomingPayments.get_list(uri_opt: {limit: "1"})["records"].last
    BankSimulator::Xml::ReturnRequests::Create.simulate(incoming_payment: incoming_payment)

    res = Numeral::V1::ReturnRequests.get_list(uri_opt: {status: "received", related_payment_id: incoming_payment["id"]})["records"].last
    res = Numeral::V1::ReturnRequests::ReturnRequestId.deny(res["id"], body: @body)
    assert res.is_a? Hash
    assert res.dig("related_payment_id") == incoming_payment["id"]
    assert res.dig("status") == "denied"
  end

  it "render error with invalid id" do
    res = Numeral::V1::ReturnRequests::ReturnRequestId.deny("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::ReturnRequests::ReturnRequestId.deny("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
