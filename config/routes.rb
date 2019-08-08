Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :chats, only: [:index, :create] do
        resources :messages, only: [:index, :create]
      end
      resources :users, only: [:index, :create]

      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'

      mount ActionCable.server, at: '/cable'
    end
  end
end
