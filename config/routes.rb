Rails.application.routes.draw do
  #get 'deliveries/new'
  #get 'deliveries/create'
  #get 'deliveries/edit'
  #get 'deliveries/update'
  #get 'order/show'
  
  root "mirrors#index"
   
  #resources :mirrors do
  #  resource :mirror_images, only: [:destroy]
  #end
resources :mirrors, only: %i[show index]

  resources :order_items
  
  get '/mirrors/:id/calculation', to: 'mirror_calculations#count', as: 'calculation'
  patch '/mirrors/:id/calculation', to: 'mirror_calculations#count_assign', as: 'patch_calculation'
  
  #get '/order', to: 'order#show'
  get '/users/:user_id/order', to: 'order#show', as: 'order' 

  get '/users/:user_id/:order_id/delivery/new', to: 'deliveries#new', as: 'new_delivery'
  post '/users/:user_id/:order_id/delivery', to: 'deliveries#create', as: 'create_delivery'
  get '/users/:user_id/:order_id/delivery/edit', to: 'deliveries#edit', as: 'edit_delivery'
  patch '/users/:user_id/:order_id/delivery', to: 'deliveries#update', as: 'update_delivery'

  get '/users/:user_id/order/order_verification', to: 'order#order_verification', as: 'order_verification' 
  post '/users/:user_id/order/order_confirm', to: 'order#order_confirm', as: 'order_confirm' 
 

  resources :users, only: %i[new create edit update]
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

#patch 'admin/order/:order_id/order_items/:id', to: 'admin/order#update', as: 'update_order_items'

end
