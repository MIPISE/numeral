# frozen_string_literal: true

require "test_helper"

describe "NumeralSdk::V1::Transactions#get_list" do
  it "render transactions list" do
    res = NumeralSdk::V1::Transactions.get_list

    assert res.is_a? Hash
    assert res.dig("records").is_a? Array
  end

  it "render error with not recognized option" do
    assert_raises(ArgumentError) { NumeralSdk::V1::Transactions.get_list(uri_opt: {test: "test"}) }
  end

  it "render only one transaction with recognized option" do
    res = NumeralSdk::V1::Transactions.get_list(uri_opt: {limit: "1"})

    assert res.is_a? Hash
    assert res.dig("records").is_a? Array
    assert res.dig("records").count <= 1
  end
end
