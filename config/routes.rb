Rails.application.routes.draw do
  resources :dishes, except: [:show]
  resources :users, except: [:show]
  resources :payments, only: [:new, :create, :show]

  root 'dishes#index'
  get '/dishes', to: 'dishes#index'
  get '/users', to: 'users#index'
  
  get '/payments', to: "payments#new"
  get '/test/hello', to: 'test#hello'
end
