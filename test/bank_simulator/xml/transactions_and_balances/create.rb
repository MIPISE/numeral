# frozen_string_literal: true

module BankSimulator
  module TransactionsAndBalances
    class Create < BankSimulator::Base
      # BankSimulator::PaymentStatusReport::Executed.call(balances: [], transactions: [], direction: "CRDT")
      # balance = {
      #   type:
      #   amount:
      #   direction:
      #   date:
      # }
      def generate_xml
        super do |doc|
          document = Ox::Element.new(:document)
          document["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
          document["xmlns"] = "urn:iso:std:iso:20022:tech:xsd:camt.053.001.02"
          doc << document

          back_to_customer = Ox::Element.new(:BkToCstmrStmt)
          document << back_to_customer

          grp_hdr = Ox::Element.new(:GrpHdr)
          back_to_customer << grp_hdr
          grp_hdr << Ox::Raw.new("<MsgId>#{SecureRandom.hex(32)}</MsgId>")
          grp_hdr << Ox::Raw.new("<CreDtTm>#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}</CreDtTm>")

          stmt = Ox::Element.new(:Stmt)
          back_to_customer << stmt
          stmt << Ox::Raw.new("<Id>#{SecureRandom.hex(32)}</Id>")
          stmt << Ox::Raw.new("<ElctrncSeqNb>1</ElctrncSeqNb>")
          stmt << Ox::Raw.new("<CreDtTm>#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}</CreDtTm>")

          acct = Ox::Element.new(:Acct)
          stmt << acct

          id = Ox::Element.new(:Id)
          acct << id
          id << Ox::Raw.new("<IBAN>#{@connected_account["account_number"]}</IBAN>")

          acct << Ox::Raw.new("<Ccy>EUR</Ccy>")

          svcr = Ox::Element.new(:Svcr)
          acct << svcr
          fin_instn_id = Ox::Element.new(:FinInstnId)
          svcr << fin_instn_id
          fin_instn_id << Ox::Raw.new("<BIC>#{@connected_account["bank_code"]}</BIC>")

          @balances.each do |balance|
            bal = Ox::Element.new(:Bal)
            stmt << bal

            tp = Ox::Element.new(:Tp)
            bal << tp

            cd_or_prtry = Ox::Element.new(:CdOrPrtry)
            tp << cd_or_prtry
            cd_or_prtry << Ox::Raw.new("<Cd>#{balance[:type]}</Cd>")

            bal << Ox::Raw.new("<Amt Ccy="EUR">#{balance[:amount] / 100}</Amt>")
            bal << Ox::Raw.new("<CdtDbtInd>#{balance[:direction]}</CdtDbtInd>")

            dt = Ox::Element.new(:Dt)
            bal << dt

            dt << Ox::Raw.new("<Dt>#{balance[:date]}</Dt>")
          end

          txs_summry = Ox::Element.new(:TxsSummry)
          stmt << txs_summry

          ttl_ntries = Ox::Element.new(:TtlNtries)
          txs_summry << ttl_ntries

          ttl_ntries << Ox::Raw.new("<NbOfNtries>#{@transactions.count}</NbOfNtries>")
          ttl_ntries << Ox::Raw.new("<Sum>#{@transactions.sum{ |tr| tr[:amount] }}</Sum>")
          ttl_ntries << Ox::Raw.new("<TtlNetNtryAmt>#{@transactions.sum{ |tr| tr[:amount] }}</TtlNetNtryAmt>")
          ttl_ntries << Ox::Raw.new("<CdtDbtInd>#{@direction}</CdtDbtInd>")

          ttl_cdt_ntries = Ox::Element.new(:TtlCdtNtries)
          txs_summry << ttl_cdt_ntries
          ttl_cdt_ntries << Ox::Raw.new("<NbOfNtries>#{@transactions.count}</NbOfNtries>")
          ttl_cdt_ntries << Ox::Raw.new("<Sum>#{@transactions.sum{ |tr| tr[:amount] }}</Sum>")

          ttl_dbt_ntries = Ox::Element.new(:TtlDbtNtries)
          txs_summry << ttl_dbt_ntries
          ttl_dbt_ntries << Ox::Raw.new("<NbOfNtries>#{@transactions.count}</NbOfNtries>")
          ttl_dbt_ntries << Ox::Raw.new("<Sum>#{@transactions.sum{ |tr| tr[:amount] }}</Sum>")

          @transactions.each do |transaction|
            ntry = Ox::Element.new(:Ntry)
            stmt << ntry
            ntry << Ox::Raw.new("<Amt Ccy="EUR">#{transaction[:amount] / 100}</Amt>")
            ntry << Ox::Raw.new("<CdtDbtInd>#{@direction}</CdtDbtInd>")
            ntry << Ox::Raw.new("<Sts>BOOK</Sts>")

            bookg_dt = Ox::Element.new(:BookgDt)
            ntry << bookg_dt
            bookg_dt << Ox::Element.new("<Dt>#{ transaction[:booking_date] }</Dt>")

            val_dt = Ox::Element.new(:ValDt)
            ntry << val_dt
            val_dt << Ox::Element.new("<Dt>#{ transaction[:value_date] }</Dt>")

            ntry << Ox::Element.new("<AcctSvcrRef>#{ Transaction.bank_data.account_servicer_reference -- String 35 characters maximum (random and unique) }</AcctSvcrRef>")

            bk_tx_cd = Ox::Element.new(:BkTxCd)
            ntry << bk_tx_cd

            domn = Ox::Element.new(:Domn)
            bk_tx_cd << domn
            domn << Ox::Raw.new("<Cd>#{ Transaction.category -- PMNT for instance (See Notes regarding Balances & Transactions > Transaction categories: BkTxCd.Domn.Cd) }</Cd>")

            fmly = Ox::Element.new(:Fmly)
            domn << fmly
            fmly << Ox::Raw.new("<Cd>#{ Transaction.category -- RCDT for instance (See Notes regarding Balances & Transactions > Transaction categories: BkTxCd.Domn.Fmly.Cd) }</Cd>")
            fmly << Ox::Raw.new("<SubFmlyCd>AAAA</SubFmlyCd>")

            prtry = Ox::Element.new(:Prtry)
            bk_tx_cd << prtry
            prtry << Ox::Raw.new("<Cd>11/0123/TRF</Cd>")
            prtry << Ox::Raw.new("<Issr>CFONB/Interne/SWIFT</Issr>")

            ntry_dtls = Ox::Element.new(:NtryDtls)
            ntry << ntry_dtls

            btch = Ox::Element.new(:Btch)
            ntry_dtls << btch
            btch << Ox::Raw.new("<PmtInfId>-</PmtInfId>")
            btch << Ox::Raw.new("<NbOfTxs>1</NbOfTxs>")

            tx_dtls = Ox::Element.new(:TxDtls)
            ntry_dtls << tx_dtls

            refs = Ox::Element.new(:Refs)
            tx_dtls << refs
            refs << Ox::Raw.new("<InstrId>-</InstrId>")
            refs << Ox::Raw.new("<EndToEndId>#{ Transaction.bank_data.end_to_end_id -- String 35 characters maximum }</EndToEndId>")

            rltd_pties = Ox::Element.new(:RltdPties)
            tx_dtls << rltd_pties

            dbtr = Ox::Element.new(:Dbtr)
            rltd_pties << dbtr
            dbtr << Ox::Raw.new("<Nm>#{ Holder name of debtor s counterparty -- String 140 characters maximum }</Nm>")

            dbtr_acct = Ox::Element.new(:DbtrAcct)
            rltd_pties << dbtr_acct

            id = Ox::Element.new(:Id)
            dbtr_acct << id
            id << Ox::Raw.new("<IBAN>#{ Account number (IBAN) of debtor''s counterparty }</IBAN>")

            rmt_inf = Ox::Element.new(:RmtInf)
            tx_dtls << rmt_inf
            rmt_inf << Ox::Raw.new("<Ustrd>#{ Transaction.description - String 140 characters maximum }</Ustrd>")

            ntry << Ox::Raw.new("<AddtlNtryInf>-</AddtlNtryInf>")
          end
        end
      end
    end
  end
end
