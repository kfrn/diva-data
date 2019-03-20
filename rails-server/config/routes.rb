# frozen_string_literal: true

Rails.application.routes.draw do
  resources :people, only: %w[index show]
  resources :divas, only: :index
end
