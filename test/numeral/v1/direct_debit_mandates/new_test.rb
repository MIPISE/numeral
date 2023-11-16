# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::DirectDebitMandates#create" do
  before do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    @body = {
      direction: "outgoing",
      type: "sepa_core",
      connected_account_id: connected_account_id,
      originating_account: {
        account_number: "FR3012739000403627545512D93",
        bank_code: "SOMEBIC0XXX",
        holder_name: "SoftwareCo",
        creditor_identifier: "FR12ZZZ123456"
      },
      receiving_account: {
        account_number: "FR0514508000301885243514G34",
        bank_code: "SOMEBIC0XXX",
        holder_name: "SoftwareCo"
      },
      sequence: "one_off",
      reference: "test-#{SecureRandom.hex(10)}",
      signature_date: "2023-05-31"
    }
  end

  it "create new direct debit mandate" do
    response = Numeral::V1::DirectDebitMandates.create(body: @body)
    assert !response["id"].nil?
    assert response["object"] == "direct_debit_mandate"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) { Numeral::V1::DirectDebitMandates.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:direction)
    assert_raises(ArgumentError) { Numeral::V1::DirectDebitMandates.create(body: @body) }
  end
end
