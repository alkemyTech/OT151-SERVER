# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: %i[update destroy]
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      resources :categories, only: %i[create update destroy]
      post '/organization/public', to: 'organizations#create'
    end
  end
end
