# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::VirtualAccounts::VirtualAccountId#update" do
  before do
    @virtual_account_id = Numeral::V1::VirtualAccounts.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    @body = {
      metadata: {
        "test" => "test1"
      },
      name: "newname"
    }
  end

  it "render updated virtual account" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId.update(@virtual_account_id, body: @body)
    assert res.is_a? Hash
    assert res.dig("id") == @virtual_account_id
    assert res.dig("metadata") == @body[:metadata]
    assert res.dig("name") == @body[:name]
  end

  it "render error with invalid id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId.update("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId.update("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) {
      Numeral::V1::VirtualAccounts::VirtualAccountId.update(@virtual_account_id, body: @body)
    }
  end
end

describe "Numeral::V1::VirtualAccounts::VirtualAccountId#disable" do
  it "render disabled direct debit mandate" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      connected_account_id: connected_account_id,
      virtual_account_number: "FR0417569000304695956582K50"
    }
    virtual_account_id = Numeral::V1::VirtualAccounts.create(body: body)["id"]
    res = Numeral::V1::VirtualAccounts::VirtualAccountId.disable(virtual_account_id)
    assert res.is_a? Hash
    assert res.dig("id") == virtual_account_id
    assert !res.dig("disabled_at").nil?
  end

  it "render error with invalid id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId.disable("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::VirtualAccounts::VirtualAccountId.disable("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
