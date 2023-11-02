# frozen_string_literal: true

require "test_helper"

describe "NumeralSdk::VERSION" do
  it "render SDK version and not nil" do
    refute_nil ::NumeralSdk::VERSION
  end
end
