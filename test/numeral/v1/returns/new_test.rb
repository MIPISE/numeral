# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::Returns#create" do
  before do
    @body = {
      related_payment_id: "fake-id",
      return_reason: "AC06"
    }
  end

  it "create new return" do
    @body[:related_payment_id] = Numeral::V1::PaymentOrders.get_list(uri_opt: {limit: "1"})["records"].last["id"]

    response = Numeral::V1::Returns.create(body: @body)
    assert !response["id"].nil?
    assert response["object"] == "return"
  end

  it "render error with not recognized body key" do
    @body[:test] = "test"
    assert_raises(ArgumentError) { Numeral::V1::Returns.create(body: @body) }
  end

  it "render error with missing required body key" do
    @body.delete(:return_reason)
    assert_raises(ArgumentError) { Numeral::V1::Returns.create(body: @body) }
  end
end
