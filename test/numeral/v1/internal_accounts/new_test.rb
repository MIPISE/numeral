# frozen_string_literal: true

require_relative "../../../test_helper"

describe "Numeral::V1::InternalAccounts#create" do
  before do
    account_list = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "4", enabled: true})
    connected_account_id = account_list["records"].select { |rec| rec["type"] == "corporate" }.first["id"]
    @body = {
      connected_account_ids: [connected_account_id],
      type: "virtual",
      name: "test-#{SecureRandom.hex(10)}",
      holder_name: "holder-test-#{SecureRandom.hex(10)}",
      account_number: "FR1717569000508742396569N67"
    }
  end

  it "create new internal account" do
    response = Numeral::V1::InternalAccounts.create(body: @body)
    assert !response["id"].nil?
    assert response["object"] == "internal_account"
    Numeral::V1::InternalAccounts::InternalAccountId.disable(response["id"])
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) { Numeral::V1::InternalAccounts.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:holder_name)
    assert_raises(ArgumentError) { Numeral::V1::InternalAccounts.create(body: @body) }
  end
end
