# frozen_string_literal: true

Rails.application.routes.draw do
  resources :creatures
  resources :explorations
  resources :levels, only: [:index, :show]
  resources :user_profiles, only: [:show, :create]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
  # resources :parts
  # resources :jobs
  # resources :items
  # resources :examples, except: [:new, :edit]
end
