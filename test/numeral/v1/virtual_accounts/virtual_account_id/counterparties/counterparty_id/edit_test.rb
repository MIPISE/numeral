# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId#assign && #unassign" do
  it "render updated virtual account" do
    virtual_account_id = Numeral::V1::VirtualAccounts.get_list(uri_opt: {limit: "1", disabled: false})["records"].last["id"]
    counterparty_id = Numeral::V1::Counterparties.get_list(uri_opt: {limit: "1", disabled: false})["records"].last["id"]
    res = Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.assign(
      virtual_account_id,
      counterparty_id
    )

    assert res.is_a? Hash
    assert res.dig("id") == virtual_account_id
    assert res.dig("counterparty_id") == counterparty_id

    res = Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.unassign(
      virtual_account_id,
      counterparty_id
    )

    assert res.is_a? Hash
    assert res.dig("id") == virtual_account_id
    assert res.dig("counterparty_id").nil?
  end

  it "render error with invalid id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.assign("123456", "123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.assign(
      "aa68a563-a54a-4aa3-8563-00a7a4e4f7aa",
      "aa68a563-a54a-4aa3-8563-00a7a4e4f7bb"
    )

    assert !res["error"].nil?
    assert res["error"] == "validation_error"
  end

  it "render error with invalid id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.unassign("123456", "123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.unassign(
      "aa68a563-a54a-4aa3-8563-00a7a4e4f7aa",
      "aa68a563-a54a-4aa3-8563-00a7a4e4f7bb"
    )

    assert !res["error"].nil?
    assert res["error"] == "validation_error"
  end
end
