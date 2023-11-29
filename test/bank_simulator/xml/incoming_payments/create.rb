# frozen_string_literal: true

module BankSimulator
  module Xml
    module IncomingPayments
      class Create < BankSimulator::Base
        # BankSimulator::Xml::IncomingPayments::Create.simulate(amount: amount)
        def generate_xml
          super do |doc|
            document = Ox::Element.new(:Document)
            document["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
            document["xmlns"] = "urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02"
            doc << document

            fIToFICstmrCdtTrf = Ox::Element.new(:FIToFICstmrCdtTrf)
            document << fIToFICstmrCdtTrf

            grp_hdr = Ox::Element.new(:GrpHdr)
            fIToFICstmrCdtTrf << grp_hdr
            grp_hdr << Ox::Raw.new("<MsgId>#{SecureRandom.hex(10)}</MsgId>")
            grp_hdr << Ox::Raw.new("<CreDtTm>#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}</CreDtTm>")
            grp_hdr << Ox::Raw.new("<NbOfTxs>1</NbOfTxs>")
            grp_hdr << Ox::Raw.new("<TtlIntrBkSttlmAmt Ccy=\"EUR\">#{@amount}</TtlIntrBkSttlmAmt>")
            grp_hdr << Ox::Raw.new("<IntrBkSttlmDt>#{Time.now.strftime("%Y-%m-%d")}</IntrBkSttlmDt>")

            sttlmInf = Ox::Element.new(:SttlmInf)
            grp_hdr << sttlmInf
            sttlmInf << Ox::Raw.new("<SttlmMtd>CLRG</SttlmMtd>")

            cdtTrfTxInf = Ox::Element.new(:CdtTrfTxInf)
            fIToFICstmrCdtTrf << cdtTrfTxInf

            pmtId = Ox::Element.new(:PmtId)
            cdtTrfTxInf << pmtId
            pmtId << Ox::Raw.new("<EndToEndId>#{id = SecureRandom.hex(10)}</EndToEndId>")
            pmtId << Ox::Raw.new("<TxId>#{id}</TxId>")

            pmtTpInf = Ox::Element.new(:PmtTpInf)
            cdtTrfTxInf << pmtTpInf

            svcLvl = Ox::Element.new(:SvcLvl)
            pmtTpInf << svcLvl
            svcLvl << Ox::Raw.new("<Cd>SEPA</Cd>")

            cdtTrfTxInf << Ox::Raw.new("<IntrBkSttlmAmt Ccy=\"EUR\">#{@amount}</IntrBkSttlmAmt>")
            cdtTrfTxInf << Ox::Raw.new("<ChrgBr>SLEV</ChrgBr>")

            dbtr = Ox::Element.new(:Dbtr)
            cdtTrfTxInf << dbtr
            dbtr << Ox::Raw.new("<Nm>External Account Holder</Nm>")

            pstlAdr = Ox::Element.new(:PstlAdr)
            dbtr << pstlAdr
            pstlAdr << Ox::Raw.new("<Ctry>FR</Ctry>")

            dbtrAcct = Ox::Element.new(:DbtrAcct)
            cdtTrfTxInf << dbtrAcct

            id = Ox::Element.new(:Id)
            dbtrAcct << id
            id << Ox::Raw.new("<IBAN>FR8110096000704584593145J13</IBAN>")

            dbtrAgt = Ox::Element.new(:DbtrAgt)
            cdtTrfTxInf << dbtrAgt

            finInstnId = Ox::Element.new(:FinInstnId)
            dbtrAgt << finInstnId
            finInstnId << Ox::Raw.new("<BIC>SOMEBICEXXX</BIC>")

            cdtrAgt = Ox::Element.new(:CdtrAgt)
            cdtTrfTxInf << cdtrAgt

            finInstnId = Ox::Element.new(:FinInstnId)
            cdtrAgt << finInstnId
            finInstnId << Ox::Raw.new("<BIC>SOMEBICEXXX</BIC>")

            cdtr = Ox::Element.new(:Cdtr)
            cdtTrfTxInf << cdtr
            cdtr << Ox::Raw.new("<Nm>PartnerCo</Nm>")

            pstlAdr = Ox::Element.new(:PstlAdr)
            cdtr << pstlAdr
            pstlAdr << Ox::Raw.new("<Ctry>FR</Ctry>")

            cdtrAcct = Ox::Element.new(:CdtrAcct)
            cdtTrfTxInf << cdtrAcct

            id = Ox::Element.new(:Id)
            cdtrAcct << id
            id << Ox::Raw.new("<IBAN>FR9317569000307144186149N25</IBAN>")

            rmtInf = Ox::Element.new(:RmtInf)
            cdtTrfTxInf << rmtInf
            rmtInf << Ox::Raw.new("<Ustrd>INCOMING PAYMENT LXFYLQNQYO</Ustrd>")
          end
        end
      end
    end
  end
end
