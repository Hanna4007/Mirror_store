Rails.application.routes.draw do
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

  resources :users, only: %i[new create edit update]
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :mirrors, except: %i[show index] do
      resource :mirror_images, only: [:destroy]
    end
  end

end
