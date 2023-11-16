# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::Counterparties#create" do
  before do
    @body = {
      name: "test-#{SecureRandom.hex(10)}"
    }
  end

  it "create new counterparty" do
    response = Numeral::V1::Counterparties.create(body: @body)
    assert !response["id"].nil?
    assert response["object"] == "counterparty"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) { Numeral::V1::Counterparties.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:name)
    assert_raises(ArgumentError) { Numeral::V1::Counterparties.create(body: @body) }
  end
end
