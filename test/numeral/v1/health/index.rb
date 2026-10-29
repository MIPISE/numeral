# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::Health#ping" do
  it "render OK status" do
    res = Numeral::V1::Health.ping

    assert res.is_a? Hash
    assert_equal "OK", res.dig("status")
  end
end
