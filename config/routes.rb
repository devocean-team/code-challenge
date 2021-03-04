Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      post :user_events, to: 'user_events#receive'
      resources :rewards, only: [:index]
      resources :users, only: [] do
        post :redeem
      end
    end
  end
end
