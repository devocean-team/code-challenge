require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @bank = banks(:piggy)
  end

  #authenticated!

  test "increase login_strike if last login was yesterday" do
    user = User.new(
      login_strike: 4,
      last_login: Date.yesterday.strftime("%Y-%m-%d"),
      bank: @bank
    )
    assert_difference("user.login_strike", +1) do
      user.authenticated!
    end
  end

  test "if user logins today multiple times, login strike should only increase once" do
    user = User.new(
      login_strike: 4,
      last_login: Date.yesterday.strftime("%Y-%m-%d"),
      bank: @bank,
    )
    assert_difference("user.login_strike", +1) do
      3.times do
        user.authenticated!
      end
    end
  end

  test "if user reaches 7 day login strike, gets points" do
    user = User.new(
      login_strike: 6,
      last_login: Date.yesterday.strftime("%Y-%m-%d"),
      bank: @bank,
      points: 0
    )
    assert_difference("user.points", +200) do
      user.authenticated!
    end
  end

  test "if user reaches 7 day login strike, login strike is resetted to 0" do
    user = User.new(
      login_strike: 6,
      last_login: Date.yesterday.strftime("%Y-%m-%d"),
      bank: @bank,
      points: 0
    )
    user.authenticated!
    assert_equal 0, user.login_strike
  end

  test "if user pays bill before expiration date, gets points" do
    @user = users(:luke)
    assert_difference("@user.points", +500) do
      @user.paid_bill(100, Date.tomorrow.strftime("%Y-%m-%d"))
    end
  end

  test "if user pays bill after expiration date, does not get points" do
    @user = users(:luke)
    assert_difference("@user.points", 0) do
      @user.paid_bill(100, Date.yesterday.strftime("%Y-%m-%d"))
    end
  end

  test "if user has less than 1000 points and makes a deposit on a savings account, does not get more points" do
    @user = users(:luke)
    assert_difference("@user.points", 0) do
      @user.made_deposit
    end

    assert_equal 300, @user.points
  end

  test "if user has more than 1000 points and makes a deposit on a savings account, does not get more points" do
    @user = users(:han)
    assert_difference("@user.points", +1000) do
      @user.made_deposit
    end
  end

  test "if user redeems a reward, it gets the points substracted" do
    @user = users(:han)
    @reward = rewards(:one)
    assert_difference("@user.points", -100) do
      @user.redeem(@reward)
    end
  end
end
