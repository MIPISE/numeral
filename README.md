# NumeralSdk

## Configuration
```rb
require "numeral_sdk"

NumeralSdk.configuration do |conf|
  conf.url_api = "url_api"
  conf.api_key = "api_key"
end
```

### Accounts
```rb
NumeralSdk::V1::ConnectedAccounts.get_list(options) # Index
NumeralSdk::V1::ConnectedAccounts::AccountId.get(account_id) # Show
```
### Balances
```rb
NumeralSdk::V1::Balances.get_list(options) # Index
NumeralSdk::V1::Balances::AccountId.get(account_id) # Show
```

