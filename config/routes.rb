# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users
      post 'auth/register', to: 'users#create'
      post '/auth/login', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
      delete '/categories/:id', to: 'categories#destroy'
    end
  end
end
