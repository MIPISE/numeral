# frozen_string_literal: true

require_relative "../.././../../test_helper"

describe "Numeral::V1::Reconciliations::ReconciliationId#get" do
  it "cancel reconciliation" do
    reconciliation_id = Numeral::V1::Reconciliations.get_list(uri_opt: {limit: "1", canceled: false}).dig("records").first["id"]
    res = Numeral::V1::Reconciliations::ReconciliationId.cancel(reconciliation_id, body: {metadata: {message: "Test cancellation"}})
    assert res.is_a? Hash
    assert_equal res.dig("id"), reconciliation_id
    assert res["canceled_at"]
  end
end
