class V1::UsersController < ApplicationController
  def redeem
    begin
      user = User.find(params[:user_id])
      reward = Reward.find(params[:reward_id])
      if user.points < reward.points
        render json: { error: 'User does not have enough points to reedem this reward' }, status: 400
        return
      end
      user.redeem(reward)

    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User or Reward not found' }, status: 400
    end
  end
end
