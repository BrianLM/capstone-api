# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :parts
  # resources :creatures
  # resources :items
  # resources :jobs
  resources :explorations
  resources :levels, only: [:index]
  resources :user_profiles, only: [:show]
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  patch '/profile/:id' => 'user_profiles#show'
  patch '/advance' => 'explorations#move'
  resources :users, only: [:index, :show]
  # post '/authentication/signin' => 'users#signin' << POC nested route
end
