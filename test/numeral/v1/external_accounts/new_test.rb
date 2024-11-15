# frozen_string_literal: true

require_relative "../../../test_helper"

describe "Numeral::V1::ExternalAccounts#create" do
  before do
    @account_number = "FR1717569000508742396569N67"
    @body = {
      holder_name: "holder-test-#{SecureRandom.hex(10)}",
      account_number: @account_number,
      bank_code: "SOMEBIC0XXX"
    }
  end

  it "create new external account" do
    response = Numeral::V1::ExternalAccounts.create(body: @body)
    if response["error"]
      # If creation is blocked because an external account not disabled already exists with this account_number,
      # we disable it before trying again to create a new one.
      existing_ext_account = Numeral::V1::ExternalAccounts.get_list(uri_opt: {limit: "1", account_number: @account_number})["records"].first
      Numeral::V1::ExternalAccounts::ExternalAccountId.disable(existing_ext_account["id"])
      response = Numeral::V1::ExternalAccounts.create(body: @body)
    end
    assert !response["id"].nil?
    assert response["object"] == "external_account"
    Numeral::V1::ExternalAccounts::ExternalAccountId.disable(response["id"])
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) { Numeral::V1::ExternalAccounts.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:holder_name)
    assert_raises(ArgumentError) { Numeral::V1::ExternalAccounts.create(body: @body) }
  end
end
