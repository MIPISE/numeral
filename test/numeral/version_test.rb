# frozen_string_literal: true

require "test_helper"

describe "Numeral::VERSION" do
  it "render SDK version and not nil" do
    refute_nil ::Numeral::VERSION
  end
end
