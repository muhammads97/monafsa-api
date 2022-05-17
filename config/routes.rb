require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobmonitor'

  root to: 'health_check#status'

  namespace :api do
    namespace :v1 do
      get '/status' => 'health_check#status'

      resources :users
      post '/login', to: 'authentication#login'
    end
  end  
end
