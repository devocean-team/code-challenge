class User < ApplicationRecord
  belongs_to :bank
  has_many :redeems
  has_many :rewards, through: :redeems

  def authenticated!
    return if last_login == Date.today
    if last_login == Date.yesterday
      increase_login_strike!
      check_login_rewards!
    else
      reset_login_strike!
    end
  end

  def paid_bill(amount, expiration_date)
    if Date.today.strftime("%Y-%m-%d") <= expiration_date
      new_points = (amount.to_f / 10).floor * 50
      update!(points: points + new_points)
    end
  end

  def made_deposit
    if savings_account = bank.savings_account(id)
      update(points: points + 1000) if savings_account[:amount] > 100 && points >= 1000
    end
  end

  def redeem(reward)
    update!(points: points - reward.points)
    rewards << reward
  end

  private

  def increase_login_strike!
    update!(
      login_strike: login_strike + 1,
      last_login: Date.today
    )
  end

  def check_login_rewards!
    if login_strike == 7
      update!(
        login_strike: 0,
        points: points + 200
      )
    end
  end

  def reset_login_strike!
    update!(
      login_strike: 1,
      last_login: Date.today
    )
  end
end
