# frozen_string_literal: true

require_relative "../../../../test_helper"

describe "Numeral::V1::AccountHolders::AccountHolderId#update" do
  before do
    @account_holder_id = Numeral::V1::AccountHolders.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    @body = {
      metadata: {
        "test" => "test1"
      }
    }
  end

  it "render updated account_holder" do
    res = Numeral::V1::AccountHolders::AccountHolderId.update(@account_holder_id, body: @body)

    assert res.is_a? Hash
    assert res.dig("id") == @account_holder_id
    assert res.dig("metadata") == @body[:metadata]
  end

  it "render error with invalid id" do
    res = Numeral::V1::AccountHolders::AccountHolderId.update("123456", body: @body)

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::AccountHolders::AccountHolderId.update("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa", body: @body)

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) {
      Numeral::V1::AccountHolders::AccountHolderId.update(@account_holder_id, body: @body)
    }
  end

  it "render error with missing required body key" do
    @body.delete(:metadata)
    assert_raises(ArgumentError) {
      Numeral::V1::AccountHolders::AccountHolderId.update(@account_holder_id, body: @body)
    }
  end
end

describe "Numeral::V1::AccountHolders::AccountHolderId#disable" do
  it "render disabled account_holder" do
    @body = {name: "test-#{SecureRandom.hex(10)}"}
    @account_holder_id = Numeral::V1::AccountHolders.create(body: @body)["id"]
    res = Numeral::V1::AccountHolders::AccountHolderId.disable(@account_holder_id)

    assert res.is_a? Hash
    assert res.dig("id") == @account_holder_id
    assert !res.dig("disabled_at").nil?
  end

  it "render error with invalid id" do
    res = Numeral::V1::AccountHolders::AccountHolderId.disable("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::AccountHolders::AccountHolderId.disable("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
