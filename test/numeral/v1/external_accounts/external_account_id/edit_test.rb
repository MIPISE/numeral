# frozen_string_literal: true

require_relative "../../../../test_helper"

describe "Numeral::V1::ExternalAccounts::ExternalAccountId#disable" do
  it "render disabled external" do
    account_number = "FR1717569000508742396569N67"
    @body = {
      holder_name: "holder-test-#{SecureRandom.hex(10)}",
      account_number: account_number,
      bank_code: "SOMEBIC0XXX"
    }
    response = Numeral::V1::ExternalAccounts.create(body: @body)
    if response["error"]
      # If creation is blocked because an external account not disabled already exists with this account_number,
      # we disable it before trying again to create a new one.
      existing_ext_account = Numeral::V1::ExternalAccounts.get_list(uri_opt: {limit: "1", account_number: @account_number})["records"].first
      Numeral::V1::ExternalAccounts::ExternalAccountId.disable(existing_ext_account["id"])
      response = Numeral::V1::ExternalAccounts.create(body: @body)
    end
    assert response.dig("status") != "disabled"
    @external_account_id = response["id"]
    res = Numeral::V1::ExternalAccounts::ExternalAccountId.disable(@external_account_id)
    assert res.is_a? Hash
    assert res.dig("id") == @external_account_id
    assert res.dig("status") == "disabled"
  end

  it "render error with invalid id" do
    res = Numeral::V1::ExternalAccounts::ExternalAccountId.disable("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::ExternalAccounts::ExternalAccountId.disable("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
