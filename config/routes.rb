# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :parts
  # resources :creatures
  # resources :items
  # resources :jobs
  resources :levels, only: [:index]
  resources :user_profiles, only: [:show]
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  # post '/authentication/signin' => 'users#signin' << POC nested route
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  patch '/profile/:id' => 'user_profiles#show'
  patch '/explorations' => 'explorations#update'
  resources :users, only: [:index, :show]
end
