require 'test_helper'

class V1::UserEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:luke)
  end

  # errors
  test "should get an error if the user does not exist" do
    post v1_user_events_url({user_id: 'fake_id'})
    assert_response :bad_request
  end

  test "should get a 400 error if the event sent does not exist" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'fake-event'
    })
    assert_response :bad_request
  end

  test "should get an error message if the event sent does not exist" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'fake-event'
    })
    assert_not_nil response.body['error']
  end

  # user authenticated
  test "should get a success response on UserAuthenticated" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'UserAuthenticated',
    })
    assert_response :success
  end

  test "should get a success message on UserAuthenticated" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'UserAuthenticated',
    })
    assert_not_nil response.body['message']
  end

  # user paid bill
  test "should get a success response on UserPaidBill" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'UserPaidBill',
      amount: 100,
      expiration_date: 2021-02-04
    })
    assert_response :success
  end

  test "should get a success message on UserPaidBill" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'UserPaidBill',
      amount: 100,
      expiration_date: 2021-02-04
    })
    assert_not_nil response.body['message']
  end

  # user paid bill
  test "should get a success response on UserMadeDepositIntoSavingsAccount" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'UserMadeDepositIntoSavingsAccount',
    })
    assert_response :success
  end

  test "should get a success message on UserMadeDepositIntoSavingsAccount" do
    post v1_user_events_url({
      user_id: @user.id,
      event: 'UserMadeDepositIntoSavingsAccount',
    })
    assert_not_nil response.body['message']
  end
end
