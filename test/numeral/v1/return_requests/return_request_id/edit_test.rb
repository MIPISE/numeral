# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::ReturnRequests::ReturnRequestId#accept" do
  it "render accepted return request" do
    #Create payment
    #Create return request
    # Accept request

    # assert res.is_a? Hash
    # assert res.dig("id") == return_request_id
    # assert res.dig("status") == "accepted"
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
  it "render denied return request" do
    #Create payment
    #Create return request
    # Accept request

    # assert res.is_a? Hash
    # assert res.dig("id") == return_request_id
    # assert res.dig("status") == "denied"
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
