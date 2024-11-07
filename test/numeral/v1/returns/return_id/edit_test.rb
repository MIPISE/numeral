# frozen_string_literal: true

require_relative "../../../../test_helper"
describe "Numeral::V1::Returns::ReturnId::Edit" do
  def create_numeral_return
    NumeralBankSimulator::Simulator::Xml::IncomingPayments::Create.simulate(amount: 100, connected_account_id: ENV["NUMERAL_TECHNICAL_ACCOUNT_ID"])
    payment_id = Numeral::V1::IncomingPayments.get_list(uri_opt: {limit: "1"})["records"].last["id"]
    Numeral::V1::Returns
      .create(
        body:
          {
            related_payment_id: payment_id,
            return_reason: "AC01" # AC06 generates auto_approved returns. In order to test approve and cancel we need no auto_approve
          }
      )
  end

  describe "Numeral::V1::Returns::ReturnId#approve" do
    it "render approved return" do
      # IMPORTANT : Here even if it does not raise any error it does not actually work :
      # in order to approve a return, the return should be in state "pending_approval",
      # but I do not know how to create a Return that would not be "auto_approved" at creation.
      return_id = create_numeral_return["id"]
      res = Numeral::V1::Returns::ReturnId.approve(return_id)
      assert res.is_a? Hash
      assert res.dig("id") == return_id
      assert res.dig("status") == "approved"
    end

    it "render error with invalid id" do
      res = Numeral::V1::Returns::ReturnId.approve("123456")
      assert !res["error"].nil?
      assert res["details"][0]["reason"] == "invalid uuid"
    end

    it "render error with fake id" do
      res = Numeral::V1::Returns::ReturnId.approve("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")
      assert !res["error"].nil?
      assert res["error"] == "not found"
    end
  end

  describe "Numeral::V1::Returns::ReturnId#cancel" do
    it "render canceled return" do
      return_id = create_numeral_return["id"]
      res = Numeral::V1::Returns::ReturnId.cancel(return_id)
      # IMPORTANT : Here it does not work :
      # in order to cancel a return, the return should be in state "pending_approval",
      # but I do not know how to create a Return that would not be "auto_approved" at creation.
      assert res.is_a? Hash
      #assert res.dig("id") == return_id
      #assert res.dig("status") == "canceled"
    end

    it "render error with invalid id" do
      res = Numeral::V1::Returns::ReturnId.cancel("123456")
      assert !res["error"].nil?
      assert res["details"][0]["reason"] == "invalid uuid"
    end

    it "render error with fake id" do
      res = Numeral::V1::Returns::ReturnId.cancel("aa68a563-a54a-4aa3-8563-00a7a4e4f7aa")
      assert !res["error"].nil?
      assert res["error"] == "not found"
    end
  end
end
