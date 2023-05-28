Rails.application.routes.draw do
  get 'order/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "mirrors#index"
  #get '/mirrors/installation_wall', to: 'mirrors#installation_wall', as: 'installation_wall'
  #get '/mirrors/installation_table', to: 'mirrors#installation_table', as: 'installation_table'
  
 
  resources :mirrors
  resources :order_items
  
  get '/mirrors/:id/calculation', to: 'mirror_calculations#count', as: 'calculation'
  patch '/mirrors/:id/calculation', to: 'mirror_calculations#count_assign', as: 'patch_calculation'
  
  get '/order', to: 'order#show'

end
