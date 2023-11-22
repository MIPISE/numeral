# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::Inquiries::InquiryId#deny" do
  before do
    @body = {
      reason: "LEGL"
    }
  end

  it "render denied inquiry" do
    # Generate inquiry

    # res = Numeral::V1::Inquiries::InquiryId.deny(inquiry_id, body: @body)

    # assert res.is_a? Hash
    # assert res.dig("id") == inquiry_id
    # assert res.dig("status") == "denied"
  end

  it "render error with invalid id" do
    res = Numeral::V1::Inquiries::InquiryId.deny("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::Inquiries::InquiryId.deny("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
