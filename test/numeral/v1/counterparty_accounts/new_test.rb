# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::CounterpartyAccounts#create" do
  before do
    counterparty_id = Numeral::V1::Counterparties.create(body: {name: "test-#{SecureRandom.hex(10)}"})["id"]
    @body = {
      holder_name: "test-#{SecureRandom.hex(10)}",
      account_number: "FR1717569000508742396569N67",
      bank_code: "SOMEBIC0XXX",
      counterparty_id: counterparty_id
    }
  end

  it "create new counterparty account" do
    response = Numeral::V1::CounterpartyAccounts.create(body: @body)

    assert !response["id"].nil?
    assert response["object"] == "counterparty_account"
    Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.disable(response["id"])
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) { Numeral::V1::CounterpartyAccounts.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:holder_name)
    assert_raises(ArgumentError) { Numeral::V1::CounterpartyAccounts.create(body: @body) }
  end
end
