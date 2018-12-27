Rails.application.routes.draw do
  resources :dishes, except: [:show]
  resources :users, except: [:show]

  root 'dishes#index'
  get '/dishes', to: 'dishes#index'
  get '/users', to: 'users#index'
  get '/payments/paypal', to: 'payments#paypal'
  
  get '/test/hello', to: 'test#hello'
end
