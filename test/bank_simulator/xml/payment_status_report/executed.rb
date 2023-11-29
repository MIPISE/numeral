# frozen_string_literal: true

module BankSimulator
  module Xml
    module PaymentStatusReport
      class Executed < BankSimulator::Base
        # BankSimulator::PaymentStatusReport::Executed.call(payment_order: po)
        def generate_xml
          super do |doc|
            document = Ox::Element.new(:Document)
            document["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
            document["xmlns"] = "urn:iso:std:iso:20022:tech:xsd:pain.002.001.03"
            doc << document

            customer_payment = Ox::Element.new(:CstmrPmtStsRpt)
            document << customer_payment

            grp_hdr = Ox::Element.new(:GrpHdr)
            grp_hdr << Ox::Raw.new("<MsgId>#{SecureRandom.hex(32)}</MsgId>")
            grp_hdr << Ox::Raw.new("<CreDtTm>#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}</CreDtTm>")
            customer_payment << grp_hdr

            debitor_agent = Ox::Element.new(:DbtrAgt)
            grp_hdr << debitor_agent

            fin_instn_id = Ox::Element.new(:FinInstnId)
            fin_instn_id << Ox::Raw.new("<BIC>#{@connected_account["bank_code"]}</BIC>")
            debitor_agent << fin_instn_id

            orgnl_grp_inf_and_sts = Ox::Element.new(:OrgnlGrpInfAndSts)
            orgnl_grp_inf_and_sts << Ox::Raw.new("<OrgnlMsgId>#{@payment_order["bank_data"]["message_id"]}</OrgnlMsgId>")
            orgnl_grp_inf_and_sts << Ox::Raw.new("<OrgnlMsgNmId>pain.001.001.03</OrgnlMsgNmId>")
            orgnl_grp_inf_and_sts << Ox::Raw.new("<OrgnlNbOfTxs>1</OrgnlNbOfTxs>")
            orgnl_grp_inf_and_sts << Ox::Raw.new("<OrgnlCtrlSum>#{@payment_order["amount"] / 100}</OrgnlCtrlSum>")
            orgnl_grp_inf_and_sts << Ox::Raw.new("<GrpSts>ACSP</GrpSts>")
            customer_payment << orgnl_grp_inf_and_sts
          end
        end
      end
    end
  end
end
