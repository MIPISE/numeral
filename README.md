# Numeral

## Configuration
```rb
require "numeral"

Numeral.configuration do |conf|
  conf.url_api = "url_api"
  conf.api_key = "api_key"
end
```

### Accounts
```rb
Numeral::V1::ConnectedAccounts.get_list(options) # Index
Numeral::V1::ConnectedAccounts::AccountId.get(account_id) # Show
```
### Balances
```rb
Numeral::V1::Balances.get_list(options) # Index
Numeral::V1::Balances::AccountId.get(account_id) # Show
```

