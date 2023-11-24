# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::Files::FileId#get" do
  it "render file" do
    return_id = Numeral::V1::Files.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    res = Numeral::V1::Files::FileId.get(return_id)

    assert res.is_a? Hash
    assert !res.dig("id").nil?
  end

  it "render error with invalid id" do
    res = Numeral::V1::Files::FileId.get("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::Files::FileId.get("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
