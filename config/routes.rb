Rails.application.routes.draw do
  get 'order/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "mirrors#index"
  resources :mirrors
  resources :order_items

  get '/order', to: 'order#show'
 
  

end
