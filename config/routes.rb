Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :chats
      resources :users, only: [:show, :create]

      post '/login', to: 'auth#create'
    end
  end
end
