require 'test_helper'

class V1::RewardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:luke)
    @rewards = rewards(:one, :two, :three)
  end

  test "should get a success response" do
    get v1_rewards_url({user_id: @user.id})
    assert_response :success
  end

  test "should get a list of reedemable rewards" do
    get v1_rewards_url({user_id: @user.id})
    assert_equal @rewards.to_json, response.body
  end

  # errors
  test "should get a 400 error if the user does not exist" do
    get v1_rewards_url({user_id: 'fake_id'})
    assert_response :bad_request
  end

  test "should get an error in the response if the user does not exist" do
    get v1_rewards_url({user_id: 'fake_id'})
    assert_not_nil response.body['error']
  end
end
