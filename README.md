# NumeralSdk

## Configuration
```rb
require "numeral_sdk"

NumeralSdk.configuration do |conf|
  conf.url_api = "url_api"
  conf.api_key = "api_key"
end
```

## Accounts
### Index
```rb
NumeralSdk::V1::ConnectedAccounts.get_list(options)
```
### Show
```rb
NumeralSdk::V1::ConnectedAccounts::AccountId.get(account_id)
```
------------------------------------
