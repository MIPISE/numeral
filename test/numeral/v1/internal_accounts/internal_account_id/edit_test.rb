# frozen_string_literal: true

require_relative "../../../../test_helper"

describe "Numeral::V1::InternalAccounts::InternalAccountId#disable" do
  it "render disabled internal" do
    account_number = "FR1717569000508742396569N67"
    account_list = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "4", enabled: true})
    connected_account_id = account_list["records"].select { |rec| rec["type"] == "corporate" }.first["id"]
    @body = {
      connected_account_ids: [connected_account_id],
      type: "virtual",
      name: "test-#{SecureRandom.hex(10)}",
      holder_name: "holder-test-#{SecureRandom.hex(10)}",
      account_number: account_number
    }
    created_res = Numeral::V1::InternalAccounts.create(body: @body)
    if created_res.dig("error")
      existing_internal_account =
        Numeral::V1::InternalAccounts.get_list(uri_opt: {limit: "1", account_number: account_number, status: "created"})["records"]&.first ||
          Numeral::V1::InternalAccounts.get_list(uri_opt: {limit: "1", account_number: account_number, status: "active"})["records"]&.first
      Numeral::V1::InternalAccounts::InternalAccountId.disable(existing_internal_account["id"])
      created_res = Numeral::V1::InternalAccounts.create(body: @body)
    end
    assert created_res.dig("status") == "active"
    @internal_account_id = created_res["id"]
    res = Numeral::V1::InternalAccounts::InternalAccountId.disable(@internal_account_id)
    assert res.is_a? Hash
    assert res.dig("id") == @internal_account_id
    assert res.dig("status") == "disabled"
  end

  it "render error with invalid id" do
    res = Numeral::V1::InternalAccounts::InternalAccountId.disable("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::InternalAccounts::InternalAccountId.disable("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
