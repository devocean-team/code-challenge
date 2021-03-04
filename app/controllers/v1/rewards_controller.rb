class V1::RewardsController < ApplicationController
  def index
    begin
      user = User.find(params[:user_id])
      rewards = Reward.where('points <= ?', user.points)
      render json: rewards, status: 200

    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: 400 unless user
    end
  end
end
