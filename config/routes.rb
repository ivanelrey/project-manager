# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'projects#index'

  resources :projects, except: [:destroy] do
    resources :comments, only: [:create]
  end
end
