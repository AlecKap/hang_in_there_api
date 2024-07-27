Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/posters', to: 'posters#index'
      get '/poster/:id', to: 'posters#show'
      post '/posters', to: 'posters#create'
      patch '/posters/:id', to: 'posters#update'
    end
  end
end
