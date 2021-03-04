class V1::UserEventsController < ApplicationController
  def receive
    begin
      user = User.find(params[:user_id])

      case params[:event]
      when 'UserAuthenticated'
        user.authenticated!

      when 'UserPaidBill'
        user.paid_bill(params[:amount], params[:expiration_date])

      when 'UserMadeDepositIntoSavingsAccount'
        user.made_deposit

      else
        render json: { error: 'Unkown event' }, status: 400
        return
      end
      render json: { message: 'Event processed correctly' }, status: 200

    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: 400
    end
  end

  private

  def paid_bill_event_params
    params.permit(:amount, :expiration_date)
  end
end
