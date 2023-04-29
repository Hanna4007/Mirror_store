Rails.application.routes.draw do
  get 'order/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "mirrors#index"
  resources :mirrors
  resources :order_items
  #get '/mirrors/:id/edit_calculation', to: 'mirror_calculations#count', as: 'calculation'
  get '/mirrors/:id/calculation', to: 'mirror_calculations#count', as: 'calculation'
  patch '/mirrors/:id/calculation', to: 'mirror_calculations#count_assign', as: 'patch_calculation'
  #put '/mirrors/:id/calculation', to: 'mirror_calculations#count_assign'

  #get '/mirror_calculations/:id/edit', to: 'mirror_calculations#count', as: 'edit_mirror_calculation'
 
  #put '/mirror_calculations/:id', to: 'mirror_calculations#count_assign', as: 'mirror_calculation'

  #resources :mirror_calculations


  get '/order', to: 'order#show'
 
  

end
