# frozen_string_literal: true

module BankSimulator
  module Xml
    module PaymentStatusReport
      class SctAccept < BankSimulator::Base
        # BankSimulator::Xml::PaymentStatusReport::SctAccept.simulate(payment_order: po)
        def generate_xml
          super do |doc|
            document = Ox::Element.new(:Document)
            document["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
            document["xmlns"] = "urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03"
            doc << document

            fi_to_fi_pmt_sts_rpt = Ox::Element.new(:FIToFIPmtStsRpt)
            document << fi_to_fi_pmt_sts_rpt

            grp_hdr = Ox::Element.new(:GrpHdr)
            fi_to_fi_pmt_sts_rpt << grp_hdr
            grp_hdr << Ox::Raw.new("<MsgId>#{SecureRandom.hex(10)}</MsgId>")
            grp_hdr << Ox::Raw.new("<CreDtTm>#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}</CreDtTm>")

            orgnl_grp_inf_and_sts = Ox::Element.new(:OrgnlGrpInfAndSts)
            fi_to_fi_pmt_sts_rpt << orgnl_grp_inf_and_sts
            orgnl_grp_inf_and_sts << Ox::Raw.new("<OrgnlMsgId>#{@payment_order["bank_data"]["message_id"]}</OrgnlMsgId>")
            orgnl_grp_inf_and_sts << Ox::Raw.new("<OrgnlMsgNmId>pacs.008.001.02</OrgnlMsgNmId>")
            orgnl_grp_inf_and_sts << Ox::Raw.new("<GrpSts>ACSP</GrpSts>")
          end
        end
      end
    end
  end
end
