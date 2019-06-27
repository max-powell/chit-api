Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :chats, only: [:index, :create]
      resources :messages, only: [:create]
      resources :users, only: :create

      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'

    end
  end
end
