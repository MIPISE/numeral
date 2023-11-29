# frozen_string_literal: true

require "test_helper"

describe "Numeral::V1::Files::FileId#cancel" do
  it "render approved file" do
    file_id = Numeral::V1::Files.get_list(uri_opt: {status: "sent", limit: 1})["records"].first["id"]

    res = Numeral::V1::Files::FileId.approve(file_id)
    assert res.is_a? Hash
    assert res.dig("id") == file_id
    assert res.dig("status") == "approved"
  end

  it "render error with invalid id" do
    res = Numeral::V1::Files::FileId.approve("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::Files::FileId.approve("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end

describe "Numeral::V1::Files::FileId#cancel" do
  it "render canceled file" do
    file_id = Numeral::V1::Files.get_list(uri_opt: {status: "sent", limit: 1})["records"].first["id"]

    res = Numeral::V1::Files::FileId.cancel(file_id)

    assert res.is_a? Hash
    assert res.dig("id") == file_id
    assert res.dig("status") == "canceled"
  end

  it "render error with invalid id" do
    res = Numeral::V1::Files::FileId.cancel("123456")

    assert !res["error"].nil?
    assert res["details"][0]["reason"] == "invalid uuid"
  end

  it "render error with fake id" do
    res = Numeral::V1::Files::FileId.cancel("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")

    assert !res["error"].nil?
    assert res["error"] == "not found"
  end
end
