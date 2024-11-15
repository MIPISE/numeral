# frozen_string_literal: true

require_relative "../../../../test_helper"

describe "Numeral::V1::AccountHolders::AccountHolderId#get" do
  it "render account_holder" do
    counterparties_list = Numeral::V1::AccountHolders.get_list(uri_opt: {limit: "1"})
    id = counterparties_list["records"].first["id"]
    res = Numeral::V1::AccountHolders::AccountHolderId.get(id)

    assert res.is_a? Hash
    assert !res.dig("id").nil?
  end

  it "render error with invalid id" do
    res = Numeral::V1::AccountHolders::AccountHolderId.get("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::AccountHolders::AccountHolderId.get("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
