Rails.application.routes.draw do
   
  root "mirrors#index"
   
  resources :mirrors, only: %i[show index] do
    resource :mirror_calculations, only: %i[show update]
  end
   
  resources :order_items
  
  resources :orders, only: %i[index show]
   
  get '/order', to: 'orders#show_current_order', as: 'show_current_order'
  get 'order/order_verification', to: 'orders#order_verification', as: 'order_verification' 
  post 'order/order_confirm', to: 'orders#order_confirm', as: 'order_confirm' 

  resource :delivery, only: %i[new create edit update], path: '/order/delivery'
    
  resources :users, only: %i[new create]
  resource :user, only: %i[edit update]
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :mirrors, except: %i[show index] do
      resource :mirror_images, only: [:destroy]
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :edit, :update]
    resources :order, only: [:index, :show, :edit, :update] do
      resources :order_items, only: [:edit, :update, :destroy] 
      resource :delivery, only: [:edit, :update] 
    end
    resource :informations, only: [:edit, :update] 
  end

  get '/delivery_information', to: 'informations#delivery_information', as: :delivery_information
  get '/company_information', to: 'informations#company_information', as: :company_information
  get '/contact_information', to: 'informations#contact_information', as: :contact_information

end
