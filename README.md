# Flourish test

## Assumptions:

- No authentication needed for the API endpoints
- Users can have accounts in only one bank

## Notes:

- In order to load this api, and have it work correctly, the connection to the bank endpoint has been commented and its response hardcoded.

```
  def user_accounts
    # response = Excon.get("#{service_url}/api/v1/user/#{@user_id}/accounts")
    # return nil if response.status != 200
    # JSON.parse(response.body)
    [
      { type: 'SIMPLE_ACCOUNT', amount: 100 },
      { type: 'SAVINGS_ACCOUNT', amount: 1000 },
      { type: 'OTHER_ACCOUNT', amount: 200 }
    ]
  end
```
