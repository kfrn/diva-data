# frozen_string_literal: true

Rails.application.routes.draw do
  resources :people, only: %w[index show]
  resources :divas, only: :index
  resources :directors, only: :index
  resources :countries, only: :index
end
