Rails.application.routes.draw do
  resources :dishes, except: [:show]
  resources :users, except: [:show]
  resources :payments, only: [:new, :create, :show]
  resources :orders, except: [:show]

  root 'dishes#index'
  get '/dishes', to: 'dishes#index'
  get '/users', to: 'users#index'
  post '/users/updateExponentPushToken', to: 'users#updateExponentPushToken'
  get '/orders', to: 'orders#index'
  get '/orders/archive', to: 'orders#getOrdersArchive'
  get '/orders/incomplete', to: 'orders#getIncomplete'
  get '/orders/user', to: 'orders#getUserOrders'
  get '/orders/userArchive', to: 'orders#getUserOrdersArchive'
  post '/orders/ready', to: 'orders#setReady'
  post '/orders/complete', to: 'orders#setComplete'
  get '/payments', to: "payments#new"

  get '/test/hello', to: 'test#hello'
end
