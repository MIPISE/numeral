# frozen_string_literal: true

require "test_helper"

describe "Helpers" do
  describe "#generate_uri" do
    it "render URI based on Class name" do
      assert NumeralSdk::V1::ConnectedAccounts.generate_uri == "v1/connectedaccounts"
    end
  end

  describe "#ensure_keys" do
    before do
      @hash = {test: "test", test2: "test2", test3: "test3", test4: "test4"}
      @required_keys = %i[test test2 test3]
      @optional_keys = %i[test4]
    end

    it "render hash required keys present" do
      assert NumeralSdk::V1::ConnectedAccounts.ensure_keys(@hash, @required_keys, @optional_keys) == @hash
    end

    it "render hash required keys present and optl missing" do
      @hash.delete(:test4)
      assert NumeralSdk::V1::ConnectedAccounts.ensure_keys(@hash, @required_keys, @optional_keys) == @hash
    end

    it "raise error when missing required key" do
      @hash.delete(:test3)
      assert_raises(ArgumentError) { NumeralSdk::V1::ConnectedAccounts.ensure_keys(@hash, @required_keys, @optional_keys) }
    end

    it "raise error when key not recognized" do
      @hash[:test5] = "test5"
      assert_raises(ArgumentError) { NumeralSdk::V1::ConnectedAccounts.ensure_keys(@hash, @required_keys, @optional_keys) }
    end
  end
end
