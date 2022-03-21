  # frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get 'auth/me', to: 'auth#show'
      post '/organization/public', to: 'organizations#create'
      post 'auth/login', to: 'auth#create'
      post 'auth/register', to: 'users#create'
      resources :announcements, only: %i[show update create]
      resources :announcements, :shallow => true do
        resources :comments, only: :create
      end
      resources :categories, only: %i[show create update destroy]
      resources :members, only: %i[index]
      resources :slides, only: %i[index]
      resources :testimonials, only: %i[index create]
      resources :users, only: %i[index update destroy]
    end
  end
end
