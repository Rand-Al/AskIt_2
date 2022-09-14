# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session, only: %i[new create destroy edit]
  resources :users, only: %i[new create edit update]
  resources :questions do
    resources :answers
  end

  namespace :admin do
    resources :users, only: %i[index create]
  end

  root 'home_page#index'
end
