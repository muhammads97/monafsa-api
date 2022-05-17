require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobmonitor'

  root to: 'health_check#status'

  scope :api do
    scope :v1 do
      get '/status' => 'health_check#status'
    end
  end  
end
