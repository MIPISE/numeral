# frozen_string_literal: true

require "test_helper"

describe "NumeralSdk::V1::ConnectedAccounts::AccountId#get" do
  it "render account" do
    account_list = NumeralSdk::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})
    @id = account_list["records"].first["id"]
    res = NumeralSdk::V1::ConnectedAccounts::AccountId.get(@id)

    assert res.is_a? Hash
    assert !res.dig("id").nil?
  end

  it "render error with invalid id" do
    res = NumeralSdk::V1::ConnectedAccounts::AccountId.get("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = NumeralSdk::V1::ConnectedAccounts::AccountId.get("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
