Rails.application.routes.draw do
   
  root "mirrors#index"
   
  resources :mirrors, only: %i[show index]

  resources :order_items
  
  get '/mirrors/:id/calculation', to: 'mirror_calculations#count', as: 'calculation'
  patch '/mirrors/:id/calculation', to: 'mirror_calculations#count_assign', as: 'patch_calculation'
  
  get '/order', to: 'order#show', as: 'order'

  get 'order/delivery/new', to: 'deliveries#new', as: 'new_delivery'
  post 'order/delivery', to: 'deliveries#create', as: 'create_delivery'
  get 'order/delivery/edit', to: 'deliveries#edit', as: 'edit_delivery'
  patch 'order/delivery', to: 'deliveries#update', as: 'update_delivery'
  
  get 'order/order_verification', to: 'order#order_verification', as: 'order_verification' 
  post 'order/order_confirm', to: 'order#order_confirm', as: 'order_confirm' 
 
  resource :user, only: %i[new create edit update]
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :mirrors, except: %i[show index] do
      resource :mirror_images, only: [:destroy]
    end
  end

  namespace :admin do
    resources :order, only: [:index, :show, :edit, :update] do
      resources :order_items, only: [:edit, :update, :destroy] 
      resource :delivery, only: [:edit, :update] 
    end
  end

end
