# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::VirtualAccounts#create" do
  it "create new direct debit mandate" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      connected_account_id: connected_account_id,
      virtual_account_number: "FR5617569000304682438151I33"
    }
    response = Numeral::V1::VirtualAccounts.create(body: body)
    assert !response["id"].nil?
    assert response["object"] == "virtual_account"

    Numeral::V1::VirtualAccounts::VirtualAccountId.disable(response["id"])
  end

  it "render error with not recognized body key" do
    body = {
      connected_account_id: "123456",
      virtual_account_number: "123456",
      test: "test"
    }
    assert_raises(ArgumentError) { Numeral::V1::VirtualAccounts.create(body: body) }
  end

  it "render error with missing required body key" do
    body = {
      connected_account_id: "123456"
    }
    assert_raises(ArgumentError) { Numeral::V1::VirtualAccounts.create(body: body) }
  end
end
