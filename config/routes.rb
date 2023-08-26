# frozen_string_literal: true

Rails.application.routes.draw do
  root 'mirrors#index'

  resources :mirrors, only: %i[show index] do
    resource :mirror_calculations, only: %i[show update]
  end

  resources :order_items
  resources :orders, only: %i[index show]
  resource :carts, only: %i[show edit update]
  resource :delivery, only: %i[new create edit update], path: '/order/delivery'
  resources :users, only: %i[new create]
  resource :user, only: %i[edit update]
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :mirrors, except: %i[show index] do
      resource :mirror_images, only: [:destroy]
    end

    resources :users, only: %i[index show new create edit update]

    resources :order, only: %i[index show edit update] do
      resources :order_items, only: %i[edit update destroy]
      resource :delivery, only: %i[edit update]
    end

    resource :informations, only: %i[edit update]
  end

  get '/delivery_information', to: 'informations#delivery_information', as: :delivery_information
  get '/company_information', to: 'informations#company_information', as: :company_information
  get '/contact_information', to: 'informations#contact_information', as: :contact_information
end
