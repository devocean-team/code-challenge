require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:luke)
    @unredeemable_reward = rewards(:unredeemable)
    @redeemable_reward = rewards(:one)
  end

  test "should get a success response when redeeming" do
    post v1_user_redeem_url({
      user_id: @user.id,
      reward_id: @redeemable_reward.id
    })
    assert_response :success
  end

  test "should create a new Redeem object" do
    assert_difference("Redeem.count", +1) do
      post v1_user_redeem_url({
        user_id: @user.id,
        reward_id: @redeemable_reward.id
      })
    end
  end

  # errors
  test "should get a 400 error if the user does not exist" do
    post v1_user_redeem_url({user_id: 'fake_id'})
    assert_response :bad_request
  end

  test "should get an error in the response if the user does not exist" do
    post v1_user_redeem_url({user_id: 'fake_id'})
    assert_not_nil response.body['error']
  end

  test "should get a 400 error if the user doesn have enough points to redeem" do
    post v1_user_redeem_url({
      user_id: @user.id,
      reward_id: @unredeemable_reward.id
    })
    assert_response :bad_request
  end

  test "should get an error if the user doesn have enough points to redeem" do
    post v1_user_redeem_url({
      user_id: @user.id,
      reward_id: @unredeemable_reward.id
    })
    assert_not_nil response.body['error']
  end
end
