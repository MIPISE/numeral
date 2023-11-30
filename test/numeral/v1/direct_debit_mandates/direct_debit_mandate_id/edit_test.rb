# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::DirectDebitMandates::DirectDebitMandateId#update" do
  before do
    @direct_debit_mandate_id = Numeral::V1::DirectDebitMandates.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    @body = {
      metadata: {
        "test" => "test1"
      }
    }
  end

  it "render updated direct debit mandate" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.update(@direct_debit_mandate_id, body: @body)

    assert res.is_a? Hash
    assert res.dig("id") == @direct_debit_mandate_id
    assert res.dig("metadata") == @body[:metadata]
  end

  it "render error with invalid id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.update("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.update("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) {
      Numeral::V1::DirectDebitMandates::DirectDebitMandateId.update(@direct_debit_mandate_id, body: @body)
    }
  end

  it "render error with missing required body key" do
    @body.delete(:metadata)
    assert_raises(ArgumentError) {
      Numeral::V1::DirectDebitMandates::DirectDebitMandateId.update(@direct_debit_mandate_id, body: @body)
    }
  end
end

describe "Numeral::V1::DirectDebitMandates::DirectDebitMandateId#disable" do
  it "render disabled direct debit mandate" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
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
    direct_debit_mandate_id = Numeral::V1::DirectDebitMandates.create(body: body)["id"]
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.disable(direct_debit_mandate_id)

    assert res.is_a? Hash
    assert res.dig("id") == direct_debit_mandate_id
    assert res.dig("status") == "disabled"
  end

  it "render error with invalid id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.disable("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.disable("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end

describe "Numeral::V1::DirectDebitMandates::DirectDebitMandateId#block" do
  it "render blocked direct debit mandate" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      direction: "incoming",
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
    direct_debit_mandate_id = Numeral::V1::DirectDebitMandates.create(body: body)["id"]
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.block(direct_debit_mandate_id)

    assert res.is_a? Hash
    assert res.dig("id") == direct_debit_mandate_id
    assert res.dig("status") == "blocked"
  end

  it "render error with invalid id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.block("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.block("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end

describe "Numeral::V1::DirectDebitMandates::DirectDebitMandateId#authorize" do
  it "render blocked direct debit mandate" do
    connected_account_id = Numeral::V1::ConnectedAccounts.get_list(uri_opt: {limit: "1"})["records"].first["id"]
    body = {
      direction: "incoming",
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
    direct_debit_mandate_id = Numeral::V1::DirectDebitMandates.create(body: body)["id"]
    Numeral::V1::DirectDebitMandates::DirectDebitMandateId.block(direct_debit_mandate_id)
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.authorize(direct_debit_mandate_id)
    assert res.is_a? Hash
    assert res.dig("id") == direct_debit_mandate_id
    assert res.dig("status") == "active"
  end

  it "render error with invalid id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.authorize("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::DirectDebitMandates::DirectDebitMandateId.authorize("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
