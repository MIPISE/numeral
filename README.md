# Numeral
-------------
_**SUMMARY**_
* [Configuration](https://github.com/MIPISE/numeral#configuration)
* [Requests](https://github.com/MIPISE/numeral#requests)
  * [Balances](https://github.com/MIPISE/numeral#balances)
  * [Connected Accounts](https://github.com/MIPISE/numeral#connectedaccounts)
  * [Counterparties](https://github.com/MIPISE/numeral#counterparties)
  * [Counterparty Accounts](https://github.com/MIPISE/numeral#counterpartyaccounts)
  * [Direct Debit Mandates](https://github.com/MIPISE/numeral#directdebitmandates)
  * [Payment Orders](https://github.com/MIPISE/numeral#paymentorders)
  * [Returns](https://github.com/MIPISE/numeral#returns)
  * [Transactions](https://github.com/MIPISE/numeral#transactions)
  * [Virtual Accounts](https://github.com/MIPISE/numeral#virtualaccounts)
-------------
## Configuration
```rb
require "numeral"

Numeral.configuration do |conf|
  conf.url_api = "url_api"
  conf.api_key = "api_key"
end
```
## Requests
### Balances
A balance is the balance of a connected account on a given date and time. Numeral connects to your bank to retrieve account statements and extract account balances.
```rb
Numeral::V1::Balances.get_list(options)
Numeral::V1::Balances::AccountId.get(account_id)
```
### ConnectedAccounts
A connected account is a bank account managed through Numeral.
```rb
Numeral::V1::ConnectedAccounts.get_list(options)
Numeral::V1::ConnectedAccounts::AccountId.get(account_id)
```
### Counterparties
A counterparty is an individual or organization you need to send money to or receive money from.
```rb
Numeral::V1::Counterparties.get_list(options)
Numeral::V1::Counterparties.create(body: body)
Numeral::V1::Counterparties::CounterpartyId.get(counterparty_id)
Numeral::V1::Counterparties::CounterpartyId.update(counterparty_id, body: body)
Numeral::V1::Counterparties::CounterpartyId.disable(counterparty_id)
```
### CounterpartyAccounts
A counterparty account is the bank account of a counterparty. It has all the account details required to send a payment to this counterparty.
```rb
Numeral::V1::CounterpartyAccounts.get_list(options)
Numeral::V1::CounterpartyAccounts.create(body: body)
Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.get(counterparty_account_id)
Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.update(counterparty_account_id, body: body)
Numeral::V1::CounterpartyAccounts::CounterpartyAccountId.disable(counterparty_account_id)
```
### Direct debit mandates
A direct debit mandate authorises a creditor (a company, public administration, or association) to collect payments from a debtor's bank account (a company, public administration, association, or individual).
```rb
Numeral::V1::DirectDebitMandates.get_list(options)
Numeral::V1::DirectDebitMandates.create(body: body)
Numeral::V1::DirectDebitMandates::DirectDebitMandateId.get(direct_debit_mandate_id)
Numeral::V1::DirectDebitMandates::DirectDebitMandateId.update(direct_debit_mandate_id, body: body)
Numeral::V1::DirectDebitMandates::DirectDebitMandateId.disable(direct_debit_mandate_id)
Numeral::V1::DirectDebitMandates::DirectDebitMandateId.block(direct_debit_mandate_id)
Numeral::V1::DirectDebitMandates::DirectDebitMandateId.authorize(direct_debit_mandate_id)
```
### PaymentOrders
A payment order is an order to create a payment to or out of one of your connected accounts. Numeral connects to your bank to process this payment and sends status updates through webhooks.
```rb
Numeral::V1::PaymentOrders.get_list(options)
Numeral::V1::PaymentOrders.create(body: body)
Numeral::V1::PaymentOrders::PaymentOrderId.get(payment_order_id)
Numeral::V1::PaymentOrders::PaymentOrderId.update(payment_order_id, body: body)
Numeral::V1::PaymentOrders::PaymentOrderId.approve(payment_order_id)
Numeral::V1::PaymentOrders::PaymentOrderId.cancel(payment_order_id)
Numeral::V1::PaymentOrders::PaymentOrderId.retry(payment_order_id, body: body)
```
### Returns
A return is the return of an incoming payment or payment order.

***⚠️ TEST failing. Can't create a return because can't validate a payment by the bank***
```rb
Numeral::V1::Returns.get_list(options)
Numeral::V1::Returns.create(body: body)
Numeral::V1::Returns::TransactionId.get(transaction_id)
```
### Transactions
A transaction is a debit or credit transaction on a connected account. Numeral connects to your bank to retrieve account statements and extract transactions.
```rb
Numeral::V1::Transactions.get_list(options)
Numeral::V1::Transactions::TransactionId.get(transaction_id)
```
### VirtualAccounts
A virtual account is a unique account number linked to a main bank account. It can be assigned to counterparties and expected payments to facilitate the identification of payments received, as part of a manual or automated reconciliation.
```rb
Numeral::V1::VirtualAccounts.get_list(options)
Numeral::V1::VirtualAccounts.create(body: body)
Numeral::V1::VirtualAccounts::VirtualAccountId.get(virtual_account_id)
Numeral::V1::VirtualAccounts::VirtualAccountId.update(virtual_account_id, body: body)
Numeral::V1::VirtualAccounts::VirtualAccountId.disable(virtual_account_id)
Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.assign(virtual_account_id, counterparty_id)
Numeral::V1::VirtualAccounts::VirtualAccountId::Counterparties::CounterpartyId.unassign(virtual_account_id, counterparty_id)
```
