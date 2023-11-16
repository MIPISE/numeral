# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::CounterpartyAccounts::CounterpartyAccountId#update" do
  before do
    @counterparty_account_id = Numeral::V1::CounterpartyAccounts.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    @body = {
      metadata: {
        "test" => "test1"
      }
    }
  end

  it "render updated counterparty account" do
    res = Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.update(@counterparty_account_id, body: @body)

    assert res.is_a? Hash
    assert res.dig("id") == @counterparty_account_id
    assert res.dig("metadata") == @body[:metadata]
  end

  it "render error with invalid id" do
    res = Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.update("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.update("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) {
      Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.update(@counterparty_account_id, body: @body)
    }
  end

  it "render error with missing required body key" do
    @body.delete(:metadata)
    assert_raises(ArgumentError) {
      Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.update(@counterparty_account_id, body: @body)
    }
  end
end

describe "Numeral::V1::CounterpartyAccounts::CounterpartyAccountId#disable" do
  it "render disabled counterparty" do
    counterparty_id = Numeral::V1::Counterparties.create(body: {name: "test-#{SecureRandom.hex(10)}"})["id"]
    @body = {
      holder_name: "test-#{SecureRandom.hex(10)}",
      account_number: "FR5610096000703834531867Y74",
      bank_code: "SOMEBIC0XXX",
      counterparty_id: counterparty_id
    }
    @counterparty_account_id = Numeral::V1::CounterpartyAccounts.create(body: @body)["id"]
    res = Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.disable(@counterparty_account_id)

    assert res.is_a? Hash
    assert res.dig("id") == @counterparty_account_id
    assert !res.dig("disabled_at").nil?
  end

  it "render error with invalid id" do
    res = Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.disable("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.disable("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
