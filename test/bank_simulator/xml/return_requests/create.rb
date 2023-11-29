# frozen_string_literal: true

module BankSimulator
  module Xml
    module ReturnRequests
      class Create < BankSimulator::Base
        # BankSimulator::Xml::ReturnRequests::Create.simulate(incoming_payment: incoming_payment)
        def generate_xml
          super do |doc|
            document = Ox::Element.new(:Document)
            document["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
            document["xmlns"] = "urn:iso:std:iso:20022:tech:xsd:camt.056.001.01"
            doc << document

            fIToFIPmtCxlReq = Ox::Element.new(:FIToFIPmtCxlReq)
            document << fIToFIPmtCxlReq

            assgnmt = Ox::Element.new(:Assgnmt)
            fIToFIPmtCxlReq << assgnmt
            assgnmt << Ox::Raw.new("<Id>#{SecureRandom.hex(10)}</Id>")

            assgnr = Ox::Element.new(:Assgnr)
            assgnmt << assgnr

            agt= Ox::Element.new(:Agt)
            assgnr << agt

            finInstnId = Ox::Element.new(:FinInstnId)
            agt << finInstnId
            finInstnId << Ox::Raw.new("<BIC>SOMEBICEXXX</BIC>")

            assgne = Ox::Element.new(:Assgne)
            assgnmt << assgne

            agt= Ox::Element.new(:Agt)
            assgne << agt

            finInstnId = Ox::Element.new(:FinInstnId)
            agt << finInstnId
            finInstnId << Ox::Raw.new("<BIC>SOMEBICEXXX</BIC>")

            assgnmt << Ox::Raw.new("<CreDtTm>#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}</CreDtTm>")

            ctrlData = Ox::Element.new(:CtrlData)
            fIToFIPmtCxlReq << ctrlData
            ctrlData << Ox::Raw.new("<NbOfTxs>1</NbOfTxs>")

            undrlyg = Ox::Element.new(:Undrlyg)
            fIToFIPmtCxlReq << undrlyg

            txInf = Ox::Element.new(:TxInf)
            undrlyg << txInf
            txInf << Ox::Raw.new("<CxlId>#{@incoming_payment["bank_data"]["transaction_id"]}</CxlId>")

            orgnlGrpInf = Ox::Element.new(:OrgnlGrpInf)
            txInf << orgnlGrpInf
            orgnlGrpInf << Ox::Raw.new("<OrgnlMsgId>#{@incoming_payment["bank_data"]["message_id"]}</OrgnlMsgId>")
            orgnlGrpInf << Ox::Raw.new("<OrgnlMsgNmId>pacs.008.001.02</OrgnlMsgNmId>")

            txInf << Ox::Raw.new("<OrgnlEndToEndId>#{@incoming_payment["bank_data"]["end_to_end_id"]}</OrgnlEndToEndId>")
            txInf << Ox::Raw.new("<OrgnlTxId>#{@incoming_payment["bank_data"]["transaction_id"]}</OrgnlTxId>")
            txInf << Ox::Raw.new("<OrgnlIntrBkSttlmAmt Ccy=\"EUR\">#{@incoming_payment["amount"] / 100}</OrgnlIntrBkSttlmAmt>")
            txInf << Ox::Raw.new("<OrgnlIntrBkSttlmDt>#{@incoming_payment["value_date"]}</OrgnlIntrBkSttlmDt>")

            cxlRsnInf = Ox::Element.new(:CxlRsnInf)
            txInf << cxlRsnInf
            cxlRsnInf << Ox::Raw.new("<Orgtr></Orgtr>")

            rsn = Ox::Element.new(:Rsn)
            cxlRsnInf << rsn
            rsn << Ox::Raw.new("<Cd>DUPL</Cd>")

            orgnlTxRef = Ox::Element.new(:OrgnlTxRef)
            txInf << orgnlTxRef

            pmtTpInf = Ox::Element.new(:PmtTpInf)
            orgnlTxRef << pmtTpInf

            svcLvl = Ox::Element.new(:SvcLvl)
            pmtTpInf << svcLvl
            svcLvl << Ox::Raw.new("<Cd>SEPA</Cd>")

            lclInstrm = Ox::Element.new(:LclInstrm)
            pmtTpInf << lclInstrm
            lclInstrm << Ox::Raw.new("<Cd>INST</Cd>")

            dbtrAcct = Ox::Element.new(:DbtrAcct)
            orgnlTxRef << dbtrAcct

            id = Ox::Element.new(:Id)
            dbtrAcct << id
            id << Ox::Raw.new("<IBAN>FR7619553000010000000000142</IBAN>")

            cdtrAcct = Ox::Element.new(:CdtrAcct)
            orgnlTxRef << cdtrAcct

            id = Ox::Element.new(:Id)
            cdtrAcct << id
            id << Ox::Raw.new("<IBAN>FR7619553000010000000000142</IBAN>")
          end
        end
      end
    end
  end
end
