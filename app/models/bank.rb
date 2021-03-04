class Bank < ApplicationRecord
  def savings_account(user_id)
    @user_id = user_id
    if accounts = user_accounts
      savings = accounts.extract! { |account| account[:type] == 'SAVINGS_ACCOUNT' }
      return savings[0] unless savings.empty?
    end
  end

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
end
